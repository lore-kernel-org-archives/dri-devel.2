Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F265CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0786F10E794;
	Mon, 18 May 2026 10:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cSy5AvpJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C0110E794
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779100652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8DhTEQbisiNb0DazV/8Ac1m1lv8eoNvuThrrZbbnYc=;
 b=cSy5AvpJdduYwAA78lJRI9lABfNVaNvl189gi96ngGPbTaqlP9nVv+c4sU2AXxw6lucpQ5
 NQ4xI2TJFixNBtWi81oZfR1MMGBa1D+L8RA5Guzw7gbxNKre5jXyeSWRSXoKTcEA/sZ8KM
 ZbOMApWNIM3miNAYDjdgCX7yHLvihGo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-MDfrDStKO8mW22opFn1zMA-1; Mon, 18 May 2026 06:37:28 -0400
X-MC-Unique: MDfrDStKO8mW22opFn1zMA-1
X-Mimecast-MFC-AGG-ID: MDfrDStKO8mW22opFn1zMA_1779100648
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d1b5bca0so8164485e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100648; x=1779705448;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8DhTEQbisiNb0DazV/8Ac1m1lv8eoNvuThrrZbbnYc=;
 b=MsiDlzP3Sgvni97KTvh8TrSmga7ZkAA0t26sGGtscL7T6tyyXJCQxVTDeo8WfHwqDY
 IfjfFxdjEInzkBx87bEELqHl5GjsB/PeAMdZ2Ed2gvYC31xpmuDd5ONZLiBxcgbHXgtU
 N5dddyJma6HQQlDALLLpeUjPNTi+dIMwgZFKQz4gM8Fv0NEVNjwWG8Szlb7HOzsnis8o
 qOseXuHBLcS2dooCxYyh0Lslvu9NNwb2v050M5OtYxqVn2TGaKINCkegKfVF49SlVYY7
 ftNlX0YbyXKLI7sovEVRYLPxgn95+dpKOc0//YO/OCQ4iymlZOdx5/vhZbuHe9qUl6Tl
 Nahg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZYFkuB/KaJS1YhNInAGoGCsPvSYL5eUXz2TUIbYtm6iqmFnuKvHel7/D6WN4ftterjOLwUBEpRkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxlpxa1QchXf3YPqezAQreU+/IM6tHjg2d2UZHf2zD5EFX9ybsX
 dRr35p+ohdN0ilwptfFVt/6K0NDHx+2TDCn/iI4QFu47YeFrM5G4t1zCy4BSQUjNoRvaz0RtSEh
 Ni5E63Lv+9s7MtXnkTJykHg+sehJM7nxmhieIXrH5BNNGiARwJNzpsYkJpdkOpYtZfpF6Fg==
X-Gm-Gg: Acq92OEV0U1wL5vvSf6Wck8Xb6fPA1Y/vAz+XBW85XeSQXBqDg95EuOxxH97w9Fd4bR
 1mXcnfKEPpSz/DZZYcBia35xQwi6CghmKCDg0zfaKeC2JAjjMxMHSrKN30GfFcUAPdMvhxhEWFe
 LrVsoR9C2Dcx+shBrnIiiJZBM4OzittSSLJQE3JL2p8p7kNSNHdJwDBYmBqmkCbZnzbZZh3bcJo
 BTatjt2CKKk5dLHRgBmf5kWG2nZRGBiUBpCB/JNYVWGEUE5r4DDdYupeeYkdogIDyHZqRcDVcEn
 gvvEy4QLwuUMI65y1fREesBE/ujpFMVr6yhu3ZCACJUyz8dMQ+JDbaUrgLS9CeUyF6zGGaEczz9
 3P42YiBU+TBqJjM8uZySBOMMNByoZFfKbn+5vTUKu1QEi/daadnkJPmZWykP1egbCzu1mAEsGUs
 /QDx4p
X-Received: by 2002:a05:600c:a30a:b0:48e:62ec:f264 with SMTP id
 5b1f17b1804b1-48fe61f29femr172075355e9.17.1779100647524; 
 Mon, 18 May 2026 03:37:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:48e:62ec:f264 with SMTP id
 5b1f17b1804b1-48fe61f29femr172074825e9.17.1779100647017; 
 Mon, 18 May 2026 03:37:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm244036005e9.10.2026.05.18.03.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 03:37:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Sen Wang <sen@ti.com>, ple@baylibre.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com
Cc: andrzej.hajda@intel.com, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devarsht@ti.com, s-jain1@ti.com, j-sahu@ti.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sen Wang
 <sen@ti.com>
Subject: Re: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio
 Helper
In-Reply-To: <87ecj9xb70.fsf@ocarina.mail-host-address-is-not-set>
References: <20260318154636.3230454-1-sen@ti.com>
 <87ecj9xb70.fsf@ocarina.mail-host-address-is-not-set>
Date: Mon, 18 May 2026 12:37:25 +0200
Message-ID: <87bjedxau2.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LreYWSYv3G2BQta13M3DFpCkPqPupFfXo82nUQArndU_1779100648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Javier Martinez Canillas <javierm@redhat.com> writes:

> Sen Wang <sen@ti.com> writes:
>
> Hello Sen,
>
>> Convert the IT66121 HDMI bridge driver from manually registering an
>> hdmi-codec platform device to using the DRM HDMI Audio Helper framework
>> via DRM_BRIDGE_OP_HDMI_AUDIO instead.
>>
>> The previous implementation manually allocated hdmi_codec_pdata,
>> registered the platform device, and implemented hdmi_codec_ops callbacks
>> including get_eld. The new approach sets DRM_BRIDGE_OP_HDMI_AUDIO on the
>> bridge, letting the framework handle the codec registration. This also
>> resolves some non-compliance issues with the current audio implementation,
>> such as HDMI audio advertising a non-functional capture stream to userspace.
>>
>> The audio callbacks are converted from hdmi_codec_ops signatures to
>> drm_bridge_funcs hdmi_audio callbacks:
>>   - it66121_audio_hw_params   -> it66121_hdmi_audio_prepare
>>   - it66121_audio_startup     -> it66121_hdmi_audio_startup
>>   - it66121_audio_shutdown    -> it66121_hdmi_audio_shutdown
>>   - it66121_audio_mute        -> it66121_hdmi_audio_mute_stream
>>
>> The it66121_audio_get_eld, it66121_audio_codec_ops, and
>> it66121_audio_codec_init functions are removed as the framework handles
>> these responsibilities.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Sen Wang <sen@ti.com>
>> ---
>
> The patch looks correct to me but I'm not that familiar with the HDMI
> helpers, so it would be great if either Dmitry or Maxime could take a
> look to the changes before merging it.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Actually, I noticed now that Dmitry already provided an r-b tag. I'll
wait for a few more days and merge this by the end of the week then.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

