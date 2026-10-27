Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7C606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=cJliREQ1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B0E10E4C2;
	Tue, 27 Oct 2026 21:33:14 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD19210E47F;
 Tue, 27 Oct 2026 21:33:02 +0000 (UTC)
Received: from [192.168.2.228] (p5dc557da.dip0.t-ipconnect.de [93.197.87.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B36174C442F7D2;
 Tue, 27 Oct 2026 22:32:44 +0100 (CET)
Message-ID: <75709eb7-6ff8-44ce-9f0c-84ff47c6ba22@molgen.mpg.de>
Date: Tue, 27 Oct 2026 22:32:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't warn about vendor infoframe for
 non-infoframe sinks
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Wentao Liang <vulab@iscas.ac.cn>, Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261027185414.162183-1-pmenzel@molgen.mpg.de>
 <ba77a6b8-f79c-496f-ad45-9314ac8f8a46@amd.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ba77a6b8-f79c-496f-ad45-9314ac8f8a46@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1793136765; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=YprbfqYF/5IHF7LNRQfGp7VZBBSU82RcpHjz3gqg6n0=; 
 b=cJliREQ1/t9kRei5RaG7Rqav8PcSgbImQ+jzkSCpmYc4D0rkcZgCr/oQUk7i1uRQOssCZLmvuUTI
 Rz9hI0ig4Ab7aFEilxaX7c5flmjuY5ydu+Fzjlr5BjA8hV+lm04pHq/0sYjDLyIY/hBsEBF5VJJ6u4
 4YyxaSCfWsd8TbL/ZmiWCgd8E6ijdbIHDlMI72tFt/29H3W4yBmZKkyuONI+73mP6io/QywKn2ACUW
 wWcp/TyjdWndQ+L1c4YrR/wd5vWvfYC/16G2f9X8cA2XhTyMJFfoow3bDGOIdEIFK24eMZS+DlrJ66
 FlVpa3vCWc+8DNUclHEs9xKyT1TIoGtw==
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Mario,


Thank you for you reply.

Am 27.10.26 um 21:48 schrieb Mario Limonciello:
> 
> 
> On 10/27/26 13:54, Paul Menzel wrote:
>> With an EIZO EV2781 connected over HDMI to an AMD Ryzen 3 2200G (Raven)
>> on an MSI B350M MORTAR (MS-7A37), Linux logs at every boot since v6.16:
>>
>>      amdgpu 0000:30:00.0: [drm] Failed to setup vendor infoframe on 
>> connector HDMI-A-1: -22
>>
>> Commit 6027cbee1900 ("drm/amd/display: Add error check for avi and
>> vendor infoframe setup function") started to log the return value of
>> drm_hdmi_vendor_infoframe_from_display_mode(). With `frame` and `mode`
>> being non-NULL, the helper only fails with -EINVAL, if the sink does
>> not support HDMI infoframes, that means, if
>> `connector->display_info.has_hdmi_infoframe` is false, and its
>> kernel-doc says, that this error can be safely ignored.
>> drm_parse_hdmi_vsdb_video() only sets `has_hdmi_infoframe`, if the HDMI
>> VSDB has HDMI_Video_present set, and drm_parse_hdmi_forum_scds() sets
>> it for sinks with an HF-SCDB. So an HDMI sink, whose VSDB lacks
>> HDMI_Video_present, triggers the warning, although nothing failed.
>>
>> The EIZO EV2781 is such a sink. Its HDMI VSDB has a payload of only
>> seven bytes (source physical address, Supports_AI, and a maximum TMDS
>> clock of 250 MHz), so the byte with HDMI_Video_present is absent, and
>> the EDID has no HF-SCDB:
>>
>>      67 03 0c 00 10 00 80 32
>>
>> Only warn, if the sink supports HDMI infoframes. The infoframe setup
>> itself is unchanged.
>>
>> Fixes: 6027cbee1900 ("drm/amd/display: Add error check for avi and 
>> vendor infoframe setup function")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5025
>> ---
>>
>> Notes:
>>
>> claude-opus-5-5 (Claude Code) assisted in analysis, code change and
>> commit message.
>>
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)

[…]

> The actual change looks reasonable to me.  But a few things about your 
> commit message you'll need to change.
> 
> 1) You are missing a S-o-b [1]

Sorry, overlooked.

> 2) Disclosing LLM should currently be done by
> "Assisted-by: LLM" [2]

Since commit 1e035297ffdadf (docs: remove Assisted-by references) it 
seems to be deprecated:

$ scripts/checkpatch.pl 
0001-drm-amd-display-Don-t-warn-about-vendor-infoframe-fo.patch
[…]
WARNING: Non-standard signature: Assisted-by:
#35:
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#35:
Assisted-by: LLM

I wanted to send v3 with the tag added, but would refrain from it now, 
if that’s alright with you.


Kind regards,

Paul


> https://docs.kernel.org/process/coding-assistants.html#signed-off-by- 
> and-developer-certificate-of-origin [1]
> https://docs.kernel.org/process/coding-assistants.html#attribution [2]
