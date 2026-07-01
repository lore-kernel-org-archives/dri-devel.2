Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CBCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF4510EE19;
	Wed,  1 Jul 2026 07:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Z32jAbC3";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7D610EE19
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782891356; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZTn/qcofW+OYO8l4UPsYHn3RAWYkUkeyX70gSqlbjX5WJQGlSVTT3qnd9Krgct4pPwNuTuJqCDTrcOaxc1XHf7w2ppx572hyswckjGlk7ewtL2QLogIJP96O+r3pnitwFr+gQS3WU4Itez7r455jGnlIh6JaVsZF79rh4C1b4wA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782891356;
 h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=N0DvgJTfQX0+oRkBhPn5QhS1/2BHY4AOlodGJmF/76M=; 
 b=UrXOBgu+KNZZF29KmwI5btRabaehWB/5HdSkqPQrPiYFDHWF0XhDpWUfIYdpBeQswX5haK2V9uX0vILtp1e3dr1MtqhSxbNVxJ8DKIMKmzvZliRHPy6YTACcse/VPfJzjcMQ8L5/H8og4vftFhR7IkDDBU7JNtLf6uA+DPjmEhw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782891356; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Content-Type:Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Message-Id:Reply-To:Cc;
 bh=N0DvgJTfQX0+oRkBhPn5QhS1/2BHY4AOlodGJmF/76M=;
 b=Z32jAbC3L2x2kzdUZgS8/E8GWajgmPUDIngfVnLdZdRNBSy7ZZsW0HUWtjAxc+m1
 JBgMx+M3oL2GKkdpKmGzVpCbSciSIROXdhfLQPnhVZI9XSMT+H3R7xHVA8BBdCTRhyU
 uEAgJvSv0tZx00t6EHquhoWcwMxq2kyvxnz/RkR4=
Received: by mx.zohomail.com with SMTPS id 1782891354149600.3822897971665;
 Wed, 1 Jul 2026 00:35:54 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Ko7jSNSE0pUPgbb0lpnbZF2B"
Message-ID: <9eb18964-fcca-4fce-9fb9-f36d762ac23e@collabora.com>
Date: Wed, 1 Jul 2026 09:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
 behind driver feature
To: dri-devel@lists.freedesktop.org
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <20260630084229.529682-2-robert.mader@collabora.com>
 <0570d22d-bf3c-4c17-b50e-58f522f25ffb@igalia.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <0570d22d-bf3c-4c17-b50e-58f522f25ffb@igalia.com>
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
--------------Ko7jSNSE0pUPgbb0lpnbZF2B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.06.26 18:57, Melissa Wen wrote:
>
>
> On 30/06/2026 10:42, Robert Mader wrote:
>> The client cap is currently advertised unconditionally, even for 
>> drivers that do
>> not support plane color pipelines. If clients supporting the later, 
>> like Wayland
>> compositors and drm_info, enable the client cap on sich drivers they 
>> will be
>> left without both color pipeline and the legacy properties 
>> COLOR_ENCODING and
>> COLOR_RANGE, effectively breaking YUV->RGB conversion support.
>>
>> Add a new driver feature and guard the client cap behind it, allowing
>> plane color pipeline and legacy YUV->RGB support to co-exist.
>
> Ouch, that's indeed a problem. Nice catch!
>
> I'm not sure if this is the right way to go because plane color 
> pipeline can be supported per plane and per hw family.
> My suggestion would be to only deprecate COLOR_ENCODING and 
> COLOR_RANGE in drm_mode_object_get_properties() if a plane 
> COLOR_PIPELINE property is attached.
> WDYT?

Hi Melissa!

I don't think we need or should use the legacy properties for drivers 
and clients that supports the new API. Once Harrys YUV conversion 
colorop series(1) lands, every plane on every hardware currently 
supporting COLOR_ENCODING and COLOR_RANGE could express that with the 
colorop API as well - even if not supporting any other operations. It 
would look roughly like this:

└───"COLOR_PIPELINE" (atomic): enum {Bypass, YUV Pipeline 123} = Bypass
     ├───Bypass
     └───YUV Pipeline 123
         └───Color Operation 123
             └───Properties
                 ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                 ├───"BYPASS" (atomic): range [0, 1] = 1
                 ├───"NEXT" (atomic, immutable): object colorop = 465
                 └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB

Doing so will be nicer for compositors/clients going forward as they'd 
only need to support a single API if they don't care about legacy 
drivers (and we can adapt all in-tree drivers).

Do you agree?

Best regards

Robert

1: https://lists.freedesktop.org/archives/dri-devel/2026-June/575655.html

>
> Melissa
>
>>
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>> ---
>>   drivers/gpu/drm/drm_ioctl.c | 2 ++
>>   include/drm/drm_drv.h       | 6 ++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index ff193155129e..96fda92e31b9 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -374,6 +374,8 @@ drm_setclientcap(struct drm_device *dev, void 
>> *data, struct drm_file *file_priv)
>>           file_priv->supports_virtualized_cursor_plane = req->value;
>>           break;
>>       case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
>> +        if (!drm_core_check_feature(dev, DRIVER_PLANE_COLOR_PIPELINE))
>> +            return -EOPNOTSUPP;
>>           if (!file_priv->atomic)
>>               return -EINVAL;
>>           if (req->value > 1)
>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> index e09559495c5b..108ddd2c8d30 100644
>> --- a/include/drm/drm_drv.h
>> +++ b/include/drm/drm_drv.h
>> @@ -116,6 +116,12 @@ enum drm_driver_feature {
>>        * the cursor planes to work correctly).
>>        */
>>       DRIVER_CURSOR_HOTSPOT           = BIT(9),
>> +    /**
>> +     * @DRIVER_PLANE_COLOR_PIPELINE:
>> +     *
>> +     * Driver supports PLANE_COLOR_PIPELINE.
>> +     */
>> +    DRIVER_PLANE_COLOR_PIPELINE    = BIT(10),
>>         /* IMPORTANT: Below are all the legacy flags, add new ones 
>> above. */
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

--------------Ko7jSNSE0pUPgbb0lpnbZF2B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 30.06.26 18:57, Melissa Wen wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0570d22d-bf3c-4c17-b50e-58f522f25ffb@igalia.com">
      <br>
      <br>
      On 30/06/2026 10:42, Robert Mader wrote:
      <br>
      <blockquote type="cite">The client cap is currently advertised
        unconditionally, even for drivers that do
        <br>
        not support plane color pipelines. If clients supporting the
        later, like Wayland
        <br>
        compositors and drm_info, enable the client cap on sich drivers
        they will be
        <br>
        left without both color pipeline and the legacy properties
        COLOR_ENCODING and
        <br>
        COLOR_RANGE, effectively breaking YUV-&gt;RGB conversion
        support.
        <br>
        <br>
        Add a new driver feature and guard the client cap behind it,
        allowing
        <br>
        plane color pipeline and legacy YUV-&gt;RGB support to co-exist.
        <br>
      </blockquote>
      <br>
      Ouch, that's indeed a problem. Nice catch!
      <br>
      <br>
      I'm not sure if this is the right way to go because plane color
      pipeline can be supported per plane and per hw family.
      <br>
      My suggestion would be to only deprecate COLOR_ENCODING and
      COLOR_RANGE in drm_mode_object_get_properties() if a plane
      COLOR_PIPELINE property is attached.
      <br>
      WDYT?
      <br>
    </blockquote>
    <p>Hi Melissa!</p>
    <p>I don't think we need or should use the legacy properties for
      drivers and clients that supports the new API. Once Harrys YUV
      conversion colorop series(1) lands, every plane on every hardware
      currently supporting COLOR_ENCODING and COLOR_RANGE could express
      that with the colorop API as well - even if not supporting any
      other operations. It would look roughly like this:</p>
    <pre>└───"COLOR_PIPELINE" (atomic): enum {Bypass, YUV Pipeline 123} = Bypass
    ├───Bypass
    └───YUV Pipeline 123
        └───Color Operation 123
            └───Properties
                ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                ├───"BYPASS" (atomic): range [0, 1] = 1
                ├───"NEXT" (atomic, immutable): object colorop = 465
                └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB</pre>
    <p>Doing so will be nicer for compositors/clients going forward as
      they'd only need to support a single API if they don't care about
      legacy drivers (and we can adapt all in-tree drivers).</p>
    <p>Do you agree?</p>
    <p>Best regards</p>
    <p>Robert</p>
    <p>1:
      <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/dri-devel/2026-June/575655.html">https://lists.freedesktop.org/archives/dri-devel/2026-June/575655.html</a></p>
    <blockquote type="cite"
      cite="mid:0570d22d-bf3c-4c17-b50e-58f522f25ffb@igalia.com"><br>
      Melissa
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Robert Mader <a class="moz-txt-link-rfc2396E" href="mailto:robert.mader@collabora.com">&lt;robert.mader@collabora.com&gt;</a>
        <br>
        ---
        <br>
          drivers/gpu/drm/drm_ioctl.c | 2 ++
        <br>
          include/drm/drm_drv.h       | 6 ++++++
        <br>
          2 files changed, 8 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/drm_ioctl.c
        b/drivers/gpu/drm/drm_ioctl.c
        <br>
        index ff193155129e..96fda92e31b9 100644
        <br>
        --- a/drivers/gpu/drm/drm_ioctl.c
        <br>
        +++ b/drivers/gpu/drm/drm_ioctl.c
        <br>
        @@ -374,6 +374,8 @@ drm_setclientcap(struct drm_device *dev,
        void *data, struct drm_file *file_priv)
        <br>
                  file_priv-&gt;supports_virtualized_cursor_plane =
        req-&gt;value;
        <br>
                  break;
        <br>
              case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
        <br>
        +        if (!drm_core_check_feature(dev,
        DRIVER_PLANE_COLOR_PIPELINE))
        <br>
        +            return -EOPNOTSUPP;
        <br>
                  if (!file_priv-&gt;atomic)
        <br>
                      return -EINVAL;
        <br>
                  if (req-&gt;value &gt; 1)
        <br>
        diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
        <br>
        index e09559495c5b..108ddd2c8d30 100644
        <br>
        --- a/include/drm/drm_drv.h
        <br>
        +++ b/include/drm/drm_drv.h
        <br>
        @@ -116,6 +116,12 @@ enum drm_driver_feature {
        <br>
               * the cursor planes to work correctly).
        <br>
               */
        <br>
              DRIVER_CURSOR_HOTSPOT           = BIT(9),
        <br>
        +    /**
        <br>
        +     * @DRIVER_PLANE_COLOR_PIPELINE:
        <br>
        +     *
        <br>
        +     * Driver supports PLANE_COLOR_PIPELINE.
        <br>
        +     */
        <br>
        +    DRIVER_PLANE_COLOR_PIPELINE    = BIT(10),
        <br>
                /* IMPORTANT: Below are all the legacy flags, add new
        ones above. */
        <br>
          </blockquote>
      <br>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Robert Mader
Consultant Software Developer 

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England &amp; Wales, no. 5513718</pre>
  </body>
</html>

--------------Ko7jSNSE0pUPgbb0lpnbZF2B--
