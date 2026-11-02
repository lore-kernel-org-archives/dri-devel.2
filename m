Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F6606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AS1MX/tH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E64C10EE8B;
	Mon,  2 Nov 2026 13:30:56 +0000 (UTC)
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327D810EE95
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:30:50 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=QSwhozA28ShgXnO4vo/Y2h8mkgH1EmGlGFODbd6mOaU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793626247; v=1; x=1794231047;
 b=AS1MX/tHy1Xh6hT5A3J7vHbxVLGdWvY/MRqsGKJmnUEkfiTxxJTch/2EYtLURPsRGTS2gsf+
 MPcb78rGN+UfaEtv7174ACh5as6ehZa2cLAtxNCaEs/yBeLKup94iH1/CqLvKnb0oPL7eMw8B6Q
 coGHnPnpsvuhGHnr9t8NbJk0=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 83255ff9d38ebe22;
 Mon, 02 Nov 2026 13:30:44 +0000
X-Mizu-Trace-ID: 83255ff9d38ebe22
X-Migadu-Flow: FLOW_OUT
Message-ID: <91573b8c-d5e3-40ab-9e9b-be55e93425c5@linux.dev>
Date: Mon, 2 Nov 2026 13:30:42 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] drm/tidss: oldi: Fix cleanup on a failed init
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-9-dc7f2b532478@ideasonboard.com>
 <c12f6a9f-983d-4704-a90b-3453ce984a2c@linux.dev>
 <15b7bfd9-8da4-4cd0-9f8b-634c03f46c5e@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <15b7bfd9-8da4-4cd0-9f8b-634c03f46c5e@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 02/11/26 11:46, Tomi Valkeinen wrote:
> Hi,
> 
> On 01/11/2026 16:14, Aradhya Bhatia wrote:
>> Hi Tomi,
>>
>> On 29/10/26 10:18, Tomi Valkeinen wrote:
>>> tidss_oldi_init() registers a bridge for each OLDI TX in turn. If a
>>> later
>>> OLDI TX fails, the bridges registered for the earlier ones are not
>>> removed.
>>>
>>> Fix this by calling tidss_oldi_deinit() in the error path.
>>>
>>> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>>   drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/
>>> tidss/tidss_oldi.c
>>> index 506507e83112..7344d86e1f13 100644
>>> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
>>> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
>>> @@ -638,5 +638,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
>>>   err_put_node:
>>>       of_node_put(child);
>>>       of_node_put(oldi_parent);
>>> +    tidss_oldi_deinit(tidss);
>>>       return ret;
>>>   }
>>>
>>
>> Since tidss_probe() (in tidss_drv.c) calls tidss_oldi_init(), it also
>> calls tidss_oldi_deinit() in its error exit path.
> Yes, but not if tidss_oldi_init() itself fails.
> 
> If we have two OLDI TXes, and the loop in tidss_oldi_init() inits the
> first one, then the second one's init fails, the code jumps to
> err_put_node. If we don't call tidss_oldi_deinit() there, the first OLDI
> TX will not be "deinited".

Thanks, I see what you mean.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

-- 
Regards
Aradhya

