Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783C606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERCctqRo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E866F10E29E;
	Sun, 15 Nov 2026 14:06:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0948010E26E;
 Sun, 15 Nov 2026 14:06:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFB29456AF;
 Sun, 15 Nov 2026 14:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BEE1F000C4;
 Sun, 15 Nov 2026 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794751611;
 bh=RwSOhU1sXIw9Fgw/IOjebI38Eb90DcWzMsDdecSXIOc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ERCctqRoahls0W1xfobOaqi2LNTtl20O0HPndcZqw0pLZX7pXweipZVbno31JeiIc
 rxCjeqffRccsRb1BajgeWD9SCvIpRMtfZgJ9AroL4nm60JFqI5WaMz9OgpuXMNa/0F
 NGGZ2XQbHevfFUgWn1LKEA2Fz7UawSzWOdsqfeqPqzw3IWZCMOQIqgKwsxRnX2v3zT
 tJgzByz5+0UBC6czxN9Ekn/Z+WzIu4rRGoSrApHS39ql/S98//DOKjVnlUoygRjTg5
 U1NJYzaxQO1FATwphqP2bfkpY/gXe3rBo5FUPf3CujfVuT4SpBA/MLFztPCdBwY93q
 Ih1OXOscY4Lxw==
Message-ID: <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
Date: Sun, 15 Nov 2026 08:06:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Content-Language: en-US
To: simonit.orig@gmail.com, Richard Hughes <richard@hughsie.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261115082042.1902826-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/15/26 02:20, Wayne Lin wrote:
> Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

Thanks Wayne.

Simon, Richard,

Can you please check that this resolves the issue raised?

Thanks,

> 
> On Tue, 03 Nov 2026 08:18:40 -0600, Mario Limonciello wrote:
>> On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
>> but the connector's "ddc" adapter ("AMDGPU DM i2c hw bus N") always
>> drives the physical i2c pins, which don't reach a native DP sink.  The
>> AUX backed adapter ("AMDGPU DM aux hw bus N") does, so userspace such as
>> fwupd, which uses the "ddc" sysfs link for DDC/CI, has to work around
>> this.
>>
>> Keep a single i2c bus per connector and pick the transport per transfer
>> based on the detected sink: if the sink is a native DP/eDP/MST sink,
>> forward the transfer to the AUX adapter, otherwise (DVI/HDMI, including
>> DP++ with a passive adapter) use the hw i2c engine as before.
>>
>> Reported-by: simonit.orig@gmail.com
>> Closes: https://github.com/fwupd/fwupd/pull/11308
>> Signed-off-by: Mario Limonciello <superm1@kernel.org>
>> ---
>> Changes in v2:
>> - Check which i2c bus to use on the fly instead of changing static symlink to
>>    avoid regressing passive adapters.
>> - Link to v1: https://patch.msgid.link/20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> index b498fc5fbb140..678caffa3d120 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> @@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
>>   	int i;
>>   	int result = -EIO;
>>   
>> +	if (!i2c->oem) {
>> +		struct dc_link *link = ddc_service->link;
>> +		struct amdgpu_dm_connector *aconnector = link->priv;
>> +
>> +		/*
>> +		 * DDC to a native DisplayPort sink is tunneled over the AUX
>> +		 * channel; the physical i2c pins only reach DVI/HDMI sinks
>> +		 * (e.g. DP++ with a passive adapter).  Route accordingly so
>> +		 * the connector's single "ddc" bus works for either sink.
>> +		 */
>> +		if (aconnector && link->local_sink &&
>> +		    dc_is_dp_signal(link->local_sink->sink_signal) &&
>> +		    aconnector->dm_dp_aux.aux.ddc.algo)
>> +			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
>> +	}
>> +
>>   	if (!ddc_service->ddc_pin)
>>   		return result;
>>   
>>
>> ---
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022
>>
>> Best regards,
>> --
>> Mario Limonciello <superm1@kernel.org>
>>
>>

