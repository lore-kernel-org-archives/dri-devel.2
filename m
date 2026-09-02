Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09915C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA7510F0D4;
	Wed,  2 Sep 2026 09:58:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58B610F0D4
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:58:38 +0000 (UTC)
X-UUID: dbeaec08a6b411f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:f200d7d2-7c63-4d3b-a018-f44822d63093, IP:0,
 U
 RL:0,TC:6,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:6
X-CID-META: VersionHash:7db8b62, CLOUDID:dc3af5c26aff118ade2bfd60e9be988e,
 BulkI
 D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:4,Content:0|14|50,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: F3AEC73A515CD08114C6AB609E202221
X-UUID: dbeaec08a6b411f19a56ed5b684f684d-20260902
Received: from [10.42.17.251] [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <oushixiong@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 2052090218; Wed, 02 Sep 2026 17:58:33 +0800
Content-Type: multipart/alternative;
 boundary="------------dVa829LpvTaAqYqF7C076q5b"
Message-ID: <07250244-f0b5-46d1-96a1-65a4b72c1a9e@kylinos.cn>
Date: Wed, 2 Sep 2026 17:58:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/modeset-helper: Add blend mode property to the legacy
 primary plane
To: Thomas Zimmermann <tzimmermann@suse.de>, oushixiong1025@163.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260902031232.165532-1-oushixiong1025@163.com>
 <ca60aed1-df30-458e-81df-49b4902af768@suse.de>
Content-Language: en-US
From: Shixiong Ou <oushixiong@kylinos.cn>
In-Reply-To: <ca60aed1-df30-458e-81df-49b4902af768@suse.de>
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

This is a multi-part message in MIME format.
--------------dVa829LpvTaAqYqF7C076q5b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thank you for your review.

Following your suggestion, I have withdrawn the original approach of
modifying the deprecated drm_crtc_init() helper. Instead, I have
prepared a new patch series that converts the remaining users of this
deprecated API (gma500, and radeon) to use  drm_crtc_init_with_planes() directly.

The new series is now ready and I will be submitting it shortly.
Best regards
Shixiong

On 2026/9/2 15:20, Thomas Zimmermann wrote:
> Hi
>
> Am 02.09.26 um 05:12 schrieb oushixiong1025@163.com:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> The primary plane created by drm_crtc_init() exposes ARGB8888, which
>> has an alpha channel, but never gets a "pixel blend mode" property, so
>> drm_mode_config_validate() warns for every driver using this helper
>> (radeon, gma500, legacy amdgpu DCE). Advertise only
>> DRM_MODE_BLEND_PREMULTI, the mode userspace always assumed when the
>> property was absent.
>
> I'd like to suggest a different strategy. The helper drm_crtc_init() 
> is deprecated and there are only 3 drivers left that call it: amdgpu, 
> gma500 and radeon.  It would be better to make a series for each that 
> integrates the helper into the driver and adapts the format array to 
> the hardware/driver's actual functionality. For gma500 at least, I'm 
> pretty sure it does not support ARGB on its primary plane.
>
> There's also work happening already for fixing amdgpu blend properties 
> IIRC.
>
> Best regards
> Thomas
>
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel 
>> format with alpha exposed")
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>> ---
>>   drivers/gpu/drm/drm_modeset_helper.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_modeset_helper.c 
>> b/drivers/gpu/drm/drm_modeset_helper.c
>> index e54584da4c3d..4c59e82af2f1 100644
>> --- a/drivers/gpu/drm/drm_modeset_helper.c
>> +++ b/drivers/gpu/drm/drm_modeset_helper.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/export.h>
>>     #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_blend.h>
>>   #include <drm/drm_client_event.h>
>>   #include <drm/drm_fourcc.h>
>>   #include <drm/drm_framebuffer.h>
>> @@ -160,6 +161,17 @@ int drm_crtc_init(struct drm_device *dev, struct 
>> drm_crtc *crtc,
>>        */
>>       primary->format_default = true;
>>   +    /*
>> +     * safe_modeset_formats[] includes ARGB8888, which has an alpha
>> +     * channel. Advertise the blend mode userspace has always assumed
>> +     * for such planes when the "pixel blend mode" property was absent,
>> +     * to satisfy drm_mode_config_validate().
>> +     */
>> +    ret = drm_plane_create_blend_mode_property(primary,
>> +                           BIT(DRM_MODE_BLEND_PREMULTI));
>> +    if (ret)
>> +        goto err_drm_plane_cleanup;
>> +
>>       ret = drm_crtc_init_with_planes(dev, crtc, primary, NULL, 
>> funcs, NULL);
>>       if (ret)
>>           goto err_drm_plane_cleanup;
>
--------------dVa829LpvTaAqYqF7C076q5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre
style="font-family: ; margin: 0px !important; overflow: auto; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-variant-numeric: ; font-variant-east-asian: ; font-weight: 400; font-stretch: ; font-size: ; line-height: ; white-space: pre-wrap; word-break: break-all; padding: 16px; color: rgb(15, 17, 21); letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span>Hi Thomas,</span>
<span></span>
<span>Thank you for your review.</span>
<span></span>
<span>Following your suggestion, I have withdrawn the original approach of</span>
<span>modifying the deprecated drm_crtc_init() helper. Instead, I have</span>
<span>prepared a new patch series that converts the remaining users of this</span>
<span>deprecated API (gma500, and radeon) to use</span> <span>drm_crtc_init_with_planes() directly</span><span>.</span>
<span></span>
<span>The new series is now ready and I will be submitting it shortly.
</span>
Best regards
Shixiong
</pre>
    <p></p>
    <div class="moz-cite-prefix">On 2026/9/2 15:20, Thomas Zimmermann
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ca60aed1-df30-458e-81df-49b4902af768@suse.de">Hi
      <br>
      <br>
      Am 02.09.26 um 05:12 schrieb <a class="moz-txt-link-abbreviated" href="mailto:oushixiong1025@163.com">oushixiong1025@163.com</a>:
      <br>
      <blockquote type="cite">From: Shixiong Ou
        <a class="moz-txt-link-rfc2396E" href="mailto:oushixiong@kylinos.cn">&lt;oushixiong@kylinos.cn&gt;</a>
        <br>
        <br>
        The primary plane created by drm_crtc_init() exposes ARGB8888,
        which
        <br>
        has an alpha channel, but never gets a "pixel blend mode"
        property, so
        <br>
        drm_mode_config_validate() warns for every driver using this
        helper
        <br>
        (radeon, gma500, legacy amdgpu DCE). Advertise only
        <br>
        DRM_MODE_BLEND_PREMULTI, the mode userspace always assumed when
        the
        <br>
        property was absent.
        <br>
      </blockquote>
      <br>
      I'd like to suggest a different strategy. The helper
      drm_crtc_init() is deprecated and there are only 3 drivers left
      that call it: amdgpu, gma500 and radeon.  It would be better to
      make a series for each that integrates the helper into the driver
      and adapts the format array to the hardware/driver's actual
      functionality. For gma500 at least, I'm pretty sure it does not
      support ARGB on its primary plane.
      <br>
      <br>
      There's also work happening already for fixing amdgpu blend
      properties IIRC.
      <br>
      <br>
      Best regards
      <br>
      Thomas
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel
        format with alpha exposed")
        <br>
        Signed-off-by: Shixiong Ou <a class="moz-txt-link-rfc2396E" href="mailto:oushixiong@kylinos.cn">&lt;oushixiong@kylinos.cn&gt;</a>
        <br>
        ---
        <br>
          drivers/gpu/drm/drm_modeset_helper.c | 12 ++++++++++++
        <br>
          1 file changed, 12 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/drm_modeset_helper.c
        b/drivers/gpu/drm/drm_modeset_helper.c
        <br>
        index e54584da4c3d..4c59e82af2f1 100644
        <br>
        --- a/drivers/gpu/drm/drm_modeset_helper.c
        <br>
        +++ b/drivers/gpu/drm/drm_modeset_helper.c
        <br>
        @@ -23,6 +23,7 @@
        <br>
          #include &lt;linux/export.h&gt;
        <br>
            #include &lt;drm/drm_atomic_helper.h&gt;
        <br>
        +#include &lt;drm/drm_blend.h&gt;
        <br>
          #include &lt;drm/drm_client_event.h&gt;
        <br>
          #include &lt;drm/drm_fourcc.h&gt;
        <br>
          #include &lt;drm/drm_framebuffer.h&gt;
        <br>
        @@ -160,6 +161,17 @@ int drm_crtc_init(struct drm_device *dev,
        struct drm_crtc *crtc,
        <br>
               */
        <br>
              primary-&gt;format_default = true;
        <br>
          +    /*
        <br>
        +     * safe_modeset_formats[] includes ARGB8888, which has an
        alpha
        <br>
        +     * channel. Advertise the blend mode userspace has always
        assumed
        <br>
        +     * for such planes when the "pixel blend mode" property was
        absent,
        <br>
        +     * to satisfy drm_mode_config_validate().
        <br>
        +     */
        <br>
        +    ret = drm_plane_create_blend_mode_property(primary,
        <br>
        +                           BIT(DRM_MODE_BLEND_PREMULTI));
        <br>
        +    if (ret)
        <br>
        +        goto err_drm_plane_cleanup;
        <br>
        +
        <br>
              ret = drm_crtc_init_with_planes(dev, crtc, primary, NULL,
        funcs, NULL);
        <br>
              if (ret)
        <br>
                  goto err_drm_plane_cleanup;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------dVa829LpvTaAqYqF7C076q5b--
