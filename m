Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mBqta6sQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3D410FFBE;
	Thu, 12 Nov 2026 10:26:53 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945CB10FFBE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:26:46 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 252D9802;
 Thu, 12 Nov 2026 11:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794479061;
 bh=Y/lQ3pq9rgGGVd75tXp0uthRUc6fWC7EXCQMcm636I0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mBqta6sQxO4C/KG4iD/5Q5P8iuJmcGhDCpZG2IVW2ZSqaM4FqPsFVLQq+7f4vZMkV
 Ij3VHJ/qEGJyqcjlv2iPMs4WFb38T2AQQrwYvKjyHpJ7oY50tavRs6j46TzMeYV2yo
 bgyNISVvAIhHz4i+B/MTh0cJyR/8jsxALO3mHBuY=
Message-ID: <8c71220e-c74f-440d-879e-06434b1f3ecc@ideasonboard.com>
Date: Thu, 12 Nov 2026 12:26:41 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm: xlnx: zynqmp_disp: use
 dmaengine_get_copy_align() accessor
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Frank.Li@oss.nxp.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>,
 "open list:DRM DRIVERS FOR XILINX" <dri-devel@lists.freedesktop.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>
References: <20261111200739.3823753-1-Frank.Li@oss.nxp.com>
 <20261111231644.GC449775@killaraus.ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261111231644.GC449775@killaraus.ideasonboard.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 12/11/2026 01:16, Laurent Pinchart wrote:
> On Wed, Nov 11, 2026 at 03:07:37PM -0500, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>
>> Use the dmaengine_get_copy_align() helper instead of directly accessing
>> the copy_align field from the DMA device structure.
>>
>> No functional change and prepare to move struct dma_device to private.
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, I assume you'll push this to drm-misc. Please let me know if
> that's not correct.

Yes, I'll pick this up.

  Tomi

>> ---
>>   drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> index e998f22686748..0753236b9546a 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> @@ -1433,7 +1433,7 @@ int zynqmp_disp_probe(struct zynqmp_dpsub *dpsub)
>>   		struct zynqmp_disp_layer *layer;
>>   
>>   		layer = &disp->layers[ZYNQMP_DPSUB_LAYER_VID];
>> -		dpsub->dma_align = 1 << layer->dmas[0].chan->device->copy_align;
>> +		dpsub->dma_align = 1 << dmaengine_get_copy_align(layer->dmas[0].chan);
>>   	}
>>   
>>   	dpsub->disp = disp;
> 

