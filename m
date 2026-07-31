Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E4C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A309610F209;
	Fri, 31 Jul 2026 10:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="VS+EQSCi";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937E610E206;
 Fri, 31 Jul 2026 10:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785492108; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YtK4SnNW+GkQaFMYDwo4eraCdHpXcdfYAcaQLaQjVYsgjVGQvNTkHOmtEpZU1ByXbt+2s39JZoxADaBpJfiSxa+YtYtAG65IIL99sS+JhZNPb/2LtpnfHk4oqKqXBRQlsOBBRShR7wFsuMUOUF8nLNb/b6BrZccpQ0bOPT9dBiU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785492108;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aX3ioftb5URgdC+2oX+YAzmF6ueujo93Y7omJwgvTQ4=; 
 b=ap6LJjsGF50/C96Fd4bYjwzPPXF1XVC2oTUbDeUTI9EeE/+8Nq69PqnjMVcPXc/ZiKuAGi596S0OyG8WjtwMNjzwLYhnuKMhK+RRipvHwMRjdwwsYMAmI3ad/bUBFCGMpmmX+wdL2kHBvZVXrT3jgIOLcjZwoZP3eD28OJKfLBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785492108; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Content-Type:Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:In-Reply-To:Message-Id:Reply-To;
 bh=aX3ioftb5URgdC+2oX+YAzmF6ueujo93Y7omJwgvTQ4=;
 b=VS+EQSCivT+vXm/k9AD1yq6RyDyt4yG4dZUto0uqtjgX7gx7+kh8ICvJLued2a+6
 mOqW6mooi1iu8WAzrjxOKm9/OoqS6JDWvuuhbRjuDZBNcr+aKaRUJxw0VXxOy3n93XR
 VI9TIzY3J7eu1oBhrSyIXwZZDBdmcdgvHNIcWEuQ=
Received: by mx.zohomail.com with SMTPS id 1785492106641402.244287356614;
 Fri, 31 Jul 2026 03:01:46 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------v5HAvdRonGnF2LpgNUlV3vv1"
Message-ID: <70f4aff6-3f2d-43a4-b80a-26d7d2aed669@collabora.com>
Date: Fri, 31 Jul 2026 12:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robert Mader <robert.mader@collabora.com>
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Melissa Wen <mwen@igalia.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
 <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
 <20260730172758.0c65485f@fluorite>
Content-Language: en-US, de-DE
In-Reply-To: <20260730172758.0c65485f@fluorite>
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
--------------v5HAvdRonGnF2LpgNUlV3vv1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chaitanya, thanks for the explanation and sorry for the delayed 
answer! I needed to think about it for a bit and would like to propose 
an idea now, see below.

On 30.07.26 16:27, Pekka Paalanen wrote:
>>>> ...
>>>> Limited to RGB",
>>>> +    [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>>>> +    [DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>>> I'm still a bit unsure how useful the later two values are,
>> You can see them being used in [1] and tested by [2]. We split out the
>> "YCbCr limited to full" block because some Intel planes have a 1DLUT
>> between it and the "YCbCr XXX Full to RGB" block. This keeps the color
>> pipeline consistent with the actual HW.
> Hi Chaitanya,
>
> it would be nice for VKMS to be able to have such a color
> pipeline only. Then userspace authors can test it.
>
> That gives me the idea, that perhaps there should be a library of color
> pipelines for VKMS that replicates actual hardware pipelines. Maybe it
> would be in the kernel, or maybe it would be in some userspace project
> if VKMS pipelines can be crafted through configfs or something else.
>
>> Based on your experience implementing the colorop in weston, do you
>> foresee any challenges in supporting limited-range framebuffers using
>> the "YCbCr Limited-to-Full" fixed matrix block?
> I cannot imagine a big problem, but it is yet another configuration
> that userspace must be explicitly prepared for.

I agree with Pekka - it shouldn't be hard to implement, especially if it 
can be tested on VKMS, but I'm worried that:

1. It could end up resulting in some "Intel-only" code that most Wayland 
compositors would need to carry around.

2. While having an additional 1D curve is great, IIUC it wouldn't be 
needed/used by Weston and similar compositors for now.

3. It would complicate the use of a cross-vendor helper for the legacy 
properties (for clients not setting 
DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE) as discussed in 
https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/


IIUC there should be a simple solution for that, though, and I'd like to 
ask if you think it would work for you: the Intel driver could just 
expose two pipelines: a "complex" one with "YCbCr Limited-to-Full" in 
the first fixed-matrix color-op and the additional 1D lut - and a 
"simple" one with a single fixed-matrix also support the "Limited to 
RGB" values. The later would waste the 1D lut in favor of compatibility 
with clients not supporting "YCbCr Limited-to-Full".

To be fully clear what I mean: IIUC right now the drm_info output of you 
pipeline looks *roughly* like this:

            └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1} = Bypass
                 ├───Bypass
                 └───Color Pipeline 1
                     ├───Color Operation 1
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 2
                     │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                     ├───Color Operation 2
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 3
                     │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                     ├───Color Operation 3
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 4
                     │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                     ├───Color Operation 4
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 5
                     │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                    ...

While I think it should look like this:

            └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1, Color Pipeline 2} = Bypass
                 ├───Bypass
                 ├───Color Pipeline 1
                 │   ├───Color Operation 11
                 │   │   └───Properties
                 │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                 │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                 │   │       ├───"NEXT" (atomic, immutable): object colorop = 12
                 │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                 │   ├───Color Operation 12
                 │   │   └───Properties
                 │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                 │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                 │   │       ├───"NEXT" (atomic, immutable): object colorop = 13
                 │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                 │   ├───Color Operation 13
                 │   │   └───Properties
                 │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                 │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                 │   │       ├───"NEXT" (atomic, immutable): object colorop = 14
                 │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                 │   ├───Color Operation 14
                 │   │   └───Properties
                 │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                 │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                 │   │       ├───"NEXT" (atomic, immutable): object colorop = 15
                 │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                    ...
                 └───Color Pipeline 2
                     ├───Color Operation 21
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 22
                     │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB
                     ├───Color Operation 22
                     │   └───Properties
                     │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                     │       ├───"BYPASS" (atomic): range [0, 1] = 1
                     │       ├───"NEXT" (atomic, immutable): object colorop = 23
                     │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                    ...

This should allow us to have the best from both worlds - maximum 
flexibility for users wanting the additional 1D lut, as well as simple 
clients just needed a drop-in replacement for the legacy properties.

Please let me know if that make sense and you think that would be 
possible (especially if I made wrong assumptions here).

> Thanks,
> pq
>
>
>> As for the "RGB709 to RGB2020" block, I can see it being useful for
>> converting SDR Rec.709 content into the Rec.2020 color space before
>> blending it with an HDR plane.

I see, thanks. At least for Weston I think it's unlikely that we will 
use that for now - the current plan is to blend in linear space and then 
use the post-blending / CRTC pipeline convert to the output color space. 
But AFAIK that's not in any way implied by Wayland, so other compositors 
may well take different approaches and use this matrix.

My request to drop it from the series was purely about landing it 
together with the corresponding implementation - like Harry just 
announced for v5 in 
https://lore.kernel.org/dri-devel/fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com/ 
- i.e. I don't have any reservations against the matrix/enum.

Best regards,

Robert

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

--------------v5HAvdRonGnF2LpgNUlV3vv1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Chaitanya, thanks for the explanation and sorry for the
      delayed answer! I needed to think about it for a bit and would
      like to propose an idea now, see below.</p>
    <div class="moz-cite-prefix">On 30.07.26 16:27, Pekka Paalanen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260730172758.0c65485f@fluorite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">...
Limited to RGB",
+    [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
+    [DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",  
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I'm still a bit unsure how useful the later two values are,  
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">You can see them being used in [1] and tested by [2]. We split out the 
"YCbCr limited to full" block because some Intel planes have a 1DLUT 
between it and the "YCbCr XXX Full to RGB" block. This keeps the color 
pipeline consistent with the actual HW.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Hi Chaitanya,

it would be nice for VKMS to be able to have such a color
pipeline only. Then userspace authors can test it.

That gives me the idea, that perhaps there should be a library of color
pipelines for VKMS that replicates actual hardware pipelines. Maybe it
would be in the kernel, or maybe it would be in some userspace project
if VKMS pipelines can be crafted through configfs or something else.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Based on your experience implementing the colorop in weston, do you 
foresee any challenges in supporting limited-range framebuffers using 
the "YCbCr Limited-to-Full" fixed matrix block?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I cannot imagine a big problem, but it is yet another configuration
that userspace must be explicitly prepared for.</pre>
    </blockquote>
    <p> I agree with Pekka - it shouldn't be hard to implement,
      especially if it can be tested on VKMS, but I'm worried that:</p>
    <p>1. It could end up resulting in some "Intel-only" code that most
      Wayland compositors would need to carry around.</p>
    <p>2. While having an additional 1D curve is great, IIUC it wouldn't
      be needed/used by Weston and similar compositors for now.</p>
    <p>3. It would complicate the use of a cross-vendor helper for the
      legacy properties (for clients not setting 
      DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE) as discussed in
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/">https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/</a></p>
    <p><br>
    </p>
    <p>IIUC there should be a simple solution for that, though, and I'd
      like to ask if you think it would work for you: the Intel driver
      could just expose two pipelines: a "complex" one with "YCbCr
      Limited-to-Full" in the first fixed-matrix color-op and the
      additional 1D lut - and a "simple" one with a single fixed-matrix
      also support the "Limited to RGB" values. The later would waste
      the 1D lut in favor of compatibility with clients not supporting
      "YCbCr Limited-to-Full".</p>
    <p>To be fully clear what I mean: IIUC right now the drm_info output
      of you pipeline looks *roughly* like this:</p>
    <pre>           └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1} = Bypass
                ├───Bypass
                └───Color Pipeline 1
                    ├───Color Operation 1
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 2
                    │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                    ├───Color Operation 2
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 3
                    │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                    ├───Color Operation 3
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 4
                    │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                    ├───Color Operation 4
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 5
                    │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                   ...
</pre>
    <p>While I think it should look like this:</p>
    <pre>           └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1, Color Pipeline 2} = Bypass
                ├───Bypass
                ├───Color Pipeline 1
                │   ├───Color Operation 11
                │   │   └───Properties
                │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                │   │       ├───"NEXT" (atomic, immutable): object colorop = 12
                │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                │   ├───Color Operation 12
                │   │   └───Properties
                │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                │   │       ├───"NEXT" (atomic, immutable): object colorop = 13
                │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                │   ├───Color Operation 13
                │   │   └───Properties
                │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                │   │       ├───"NEXT" (atomic, immutable): object colorop = 14
                │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
                │   ├───Color Operation 14
                │   │   └───Properties
                │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
                │   │       ├───"NEXT" (atomic, immutable): object colorop = 15
                │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                   ...
                └───Color Pipeline 2
                    ├───Color Operation 21
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 22
                    │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB
                    ├───Color Operation 22
                    │   └───Properties
                    │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
                    │       ├───"BYPASS" (atomic): range [0, 1] = 1
                    │       ├───"NEXT" (atomic, immutable): object colorop = 23
                    │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
                   ...

</pre>
    <p>This should allow us to have the best from both worlds - maximum
      flexibility for users wanting the additional 1D lut, as well as
      simple clients just needed a drop-in replacement for the legacy
      properties.</p>
    <p>Please let me know if that make sense and you think that would be
      possible (especially if I made wrong assumptions here).</p>
    <blockquote type="cite" cite="mid:20260730172758.0c65485f@fluorite">
      <pre wrap="" class="moz-quote-pre">Thanks,
pq


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">As for the "RGB709 to RGB2020" block, I can see it being useful for 
converting SDR Rec.709 content into the Rec.2020 color space before 
blending it with an HDR plane.</pre>
      </blockquote>
    </blockquote>
    <p>I see, thanks. At least for Weston I think it's unlikely that we
      will use that for now - the current plan is to blend in linear
      space and then use the post-blending / CRTC pipeline convert to
      the output color space. But AFAIK that's not in any way implied by
      Wayland, so other compositors may well take different approaches
      and use this matrix.</p>
    <p>My request to drop it from the series was purely about landing it
      together with the corresponding implementation - like Harry just
      announced for v5 in
      <a class="moz-txt-link-freetext"
href="https://lore.kernel.org/dri-devel/fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com/">https://lore.kernel.org/dri-devel/fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com/</a>
      - i.e. I don't have any reservations against the matrix/enum.</p>
    <p>Best regards,</p>
    <p>Robert</p>
    <pre class="moz-signature" cols="72">-- 
Robert Mader
Consultant Software Developer 

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England &amp; Wales, no. 5513718</pre>
  </body>
</html>

--------------v5HAvdRonGnF2LpgNUlV3vv1--
