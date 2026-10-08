Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83C2CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F375910E5FF;
	Thu,  8 Oct 2026 08:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LbpqK6dW";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482D310E766
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 08:27:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so25093395e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791448028; x=1792052828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cDnEFJrAYNmZIA6bszuyNmXd6pp1X1kbMGgs/I8iGxE=;
 b=LbpqK6dW26TcVAs89QkBcVLgJW6yGFepBjjHnFtjkRrKLtsxkQ0pnCEdt0bXl4+mbH
 TbpdrkHc8erRNuyMEqtKKi/74H4TSI04kvuGRsNqBHqzSYTbwnp5bSdDEITttBTGs1oN
 1E1i/wUkwACSDXB0lUP5Ydpez98IXh+iSMFXpv4IYxXI6Taf8EcRfKNg44lrhvpbZ2KW
 RjiMbM2+bJOixgza8+/wpi/oZmBnPLlr+/2AYqUjia3osvezBeL2mpOIx8umaUZT525w
 EKhgtSkDDgm3/EzDA3c55Xv24DyQr4nk1LG9+YaVPgfHDQqWdJzZJ9EISSQIQWdnU3js
 PNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791448028; x=1792052828;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cDnEFJrAYNmZIA6bszuyNmXd6pp1X1kbMGgs/I8iGxE=;
 b=siOksERurqRIUk917SlKwVAC1EixPHhE+7yuY+TaVX62+5mWtShLtsi9Mj8lkmNtFz
 xZSzL13+eQjkarLmS87CmOQIJyZ7wFML3AHxl5TKOxTcxst+sZNg+MXtEfjPitXB17KT
 /fkoDwy6wnlIBsylJSwa5fNS5LrCPzdzKEKeNo3vnATl9HLTz2wLVIcJANGS9ZcKhGvj
 XtJz09NsSUqhyc+MDNk36wWcBMesMdk4V4nRsoBj9TWEAt7yUzQuPkoJRfy4Ff3v/gf9
 N2G4FX8yQrJebBe3On20+1qgIuXi6KO74zXWklyZT5MDPj7YLvd9bttb/qvS4l5z8Ngx
 N94A==
X-Forwarded-Encrypted: i=1;
 AKwUvByJNUAD3V2863M5GZOUeyFTpoBmwQG52MGMm5+ZFNWlx5DqZxq0FuQQ5Z1CMcu+QQDsmDpanhdzMa8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUMiD3djW+OEaBwTx1VEtC1EOLoJBOG2ybvpLAMofpyKnhkg6p
 nb1SP6unW+XjAqtl1qX+T7HF/3zlkAeNEZWyN4e+KlUTEUcA2W71K0syQ9H5aJ823ks=
X-Gm-Gg: AYBFou0L0jn0dA2TQecOyT9LhJBn8sXWljs6Fu/Tz3HPvS6b7mA8DFDnOZNwv6xfrwy
 d4MN1FMrQ79861jivogdAYvt77FNNIpWNnJwz3cMuZh35evzeJ3IQ2Cy3bt2E1OG5Viy5kN8a1O
 5nC9siPhUIcMzqbx1IHeKTo5wFzOrcUaLNXT/7Ynr/KQ+GH0QxJ/cjl0Fm07zRYL9ZdLwxoSukc
 aT7fiX0pXAWwdHaOh6eAs1k/dqxglOs6zVH6byq35JjsK/qcFrnK4T4er1TZPvhbswHSx8HzcMe
 zUaRGTKqlOjUNl04M8lbOflWprHLXFtFydx4hGxX0sGGeW4bcQ0wbuS/BgShMsf3jm7LNTP+eIa
 yQn1vXJMq1Z1rk+ZqMrVtHaznVRyR/LFNumAHGpgOyVp8z3TxKYq4gHHjKRJEvztafVqCdpdj1c
 5RpIhalQCdOBPEHocHFEs3to4llEOFeDv2hFXH6Lxr+Q0R5DoWaoSRY3EaExkkGzZMYyaqHMT1U
 8zgJCl2yokGl5snR7rp7NJL9lq5YCZr
X-Received: by 2002:a05:600c:4693:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a180648ff1mr80887095e9.29.1791448027436; 
 Thu, 08 Oct 2026 01:27:07 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843d1e0bsm51493935e9.6.2026.10.08.01.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 01:27:06 -0700 (PDT)
Message-ID: <c23f91fd-a5d5-46a2-b4d7-3e33a87a348e@linaro.org>
Date: Thu, 8 Oct 2026 10:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics panel support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <CAD++jLkX0m6_GJd4Pd1Ko4tghta4AXQ5ALZpLe_x-3xxqu1Cvw@mail.gmail.com>
 <668e83d0-a017-4f59-bc76-bf6c9a80b5ba@kernel.org>
 <CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com>
 <bc3e618f-2e7a-4439-9466-8cd9695242e5@linaro.org>
 <2lcpzwh7fxecpffnakpnp5lecrm3e6u64ztat7cd75nuxofxa2@clj27bzgjy3r>
 <4d053234-06d8-4268-b60a-2fccc78da654@linaro.org>
 <d3xs3kzc2wg5lkouaemdicrbtsoquff6bvmnlmuxwh4kspfs2d@b77l43axr6a4>
 <8cf6ec52-fb36-44e7-831c-2bb24214f591@linaro.org>
 <pyl6bihy4zsyhmblrgvuvov2gi2jz5ktpbcz4u3r53qw7h725y@4wzvce345wwh>
 <b48f9b77-5b11-483d-b031-81da16c5c73a@linaro.org>
 <cqo2n43vq4v7txg6j7ss6dyzpnqdbm265m5xedjtrp5tn7b56c@xlqtrwvpvoly>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <cqo2n43vq4v7txg6j7ss6dyzpnqdbm265m5xedjtrp5tn7b56c@xlqtrwvpvoly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 10/5/26 13:15, Dmitry Baryshkov wrote:
> On Mon, Oct 05, 2026 at 10:54:41AM +0200, Neil Armstrong wrote:
>> On 10/5/26 04:22, Dmitry Baryshkov wrote:
>>> On Sun, Oct 04, 2026 at 05:51:44PM +0200, Neil Armstrong wrote:
>>>> On 10/1/26 02:43, Dmitry Baryshkov wrote:
>>>>> On Wed, Sep 30, 2026 at 09:18:55PM +0200, Neil Armstrong wrote:
>>>>>> On 9/30/26 21:04, Dmitry Baryshkov wrote:
>>>>>>> On Wed, Sep 30, 2026 at 06:43:47PM +0200, Neil Armstrong wrote:
>>>>>>>> On 9/30/26 09:44, Linus Walleij wrote:
>>>>>>>>> On Tue, Sep 29, 2026 at 3:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>>> This entire binding seems like stitching two devices together, which
>>>>>>>>>> might be fine (I don't even remember this stuff... two months old) or
>>>>>>>>>> might be artificial grouping of separate devices.
>>>>>>>>>
>>>>>>>>> I think that's a good point and fair pushback.
>>>>>>>>>
>>>>>>>>> Neil and Jun talk about it yesterday at XDC (1:15 into the stream):
>>>>>>>>> https://www.youtube.com/watch?v=6tNGW8PoSzw
>>>>>>>>>
>>>>>>>>> The current binding does not reflect the physical topology of the
>>>>>>>>> actual device, and the bindings need improvements. I have a feeling
>>>>>>>>> there is one display controller with two physical panels.
>>>>>>>>
>>>>>>>> No there's really 2 controller and 2 separate panels, but they are not
>>>>>>>> classic panel, they are a pair of panels+lens which are in front of
>>>>>>>> the eyes which forms a single "image" for the brain, so they are
>>>>>>>> technically a single display and requires to be hard synchronized.
>>>>>>>
>>>>>>> Yes. However this approach makes it impossible to share the code between
>>>>>>> the double-panel drivers and single-panel drivers. I think, that the
>>>>>>> panel driver should still reference a single glass+DDIC, while letting
>>>>>>> the DSI host driver to handle the bifurcation.
>>>>>>
>>>>>> Yes, and no, it must really be considered as a "single panel driven by 2 identical controllers",
>>>>>> and even this is really purely software implementation issue.
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>>>> Describing both panels into separate nodes would only be possible
>>>>>>>> if we described a "VR display complex" nodes linked to both panels
>>>>>>>> but this would probably be solved by actually describing the "display"
>>>>>>>> linked to a DDIC controller and is out of subject for this serie,
>>>>>>>> and can be added later when we properly define things.
>>>>>>>
>>>>>>> I like the VR complex idea. In the end, you have two modes which you
>>>>>>> most likely might want to support:
>>>>>>> - L+R, having double-width CRTC scanning over a double-width framebuffer
>>>>>>> - Mx2, having a single-width CRTC and a single-width framebuffer
>>>>>>>       displaying the same picture to both eyes. I can imaging that knowing
>>>>>>>       about L+R might be an explicit opt-in feature of the DRM interface.
>>>>>>>
>>>>>>
>>>>>> This makes no sense to support both modes, and this will never be used,
>>>>>> and anyway this is purely software implementation.
>>>>>>
>>>>>> We're defining bindings here, describing the real reality, not hypothetical
>>>>>> situation that will never happen.
>>>>>
>>>>> Let's ignore software issues. On the hardware side, you have two
>>>>> distinct DSI panels, each having its own set of controls, own DSI link
>>>>> and own backlight control.
>>>>>
>>>>
>>>> OK so let's see the problem in another angle, if we had 2 DS links 2 physical
>>>> controllers, 2 physically distinct panels but forms an unique display.
>>>
>>> Imaging the case: through the time the backlight LEDs on the right eye
>>> age faster than the ones on the left eye, so we need to apply dynamic
>>> correction to the backlight, dynamically calibrating the coefficient to
>>> be applied to the LED brightness (or even worse, dynamically applieing
>>> the _curve_ to compensate for the brightness difference).
>>>
>>> Note, I don't have any information here, if such a difference can exist
>>> or if it can appear through the time, or if the xR DDICs can handle it
>>> on its own via a pre-programmed LUT, so you can totally say that the
>>> argument is moot and I won't even argue here.
>>>
>>>>
>>>> Describing it in separate distincts nodes is wrong since it doesn't reflect
>>>> that it's an unified display, so either we define :
>>>> - a "combined-display" bridge defined as:
>>>>     - a separate top node in / like connectors with a graph from the DSI links to each panel
>>>>     - a DSI subnode with 2 panels as subnode, port graph from both dsi to both sub-panels
>>>> - a "R63455" panel bindings with 2 subpanels as Linus shared in https://lore.kernel.org/all/CAD++jLkyEPY5cFg_pHb71yG52iLwS9tQDpcHu=TTBknQMeFctw@mail.gmail.com/
>>>>
>>>> I think it would be interesting to have the "combined-display", with a connector-like node,
>>>> which will do all the split-dsi dual-panel logic for us and leave use implementing simple panel
>>>> drivers.
>>>>
>>>> The outline would be:
>>>>
>>>> =====><=======================================
>>>> / {
>>>>
>>>> 	xr-display {
>>>> 		compatible = "combined-display";
>>>>
>>>> 		ports {
>>>> 			port@0 {
>>>> 				combined_dsi0: endpoint {
>>>> 					remote-endpoint = <&dsi0_out>;
>>>> 				};
>>>> 			};
>>>> 			port@1 {
>>>> 				combined_dsi1: endpoint {
>>>> 					remote-endpoint = <&dsi1_out>;
>>>> 				};
>>>> 			};
>>>> 			port@2 {
>>>> 				combined_panel0: endpoint {
>>>> 					remote-endpoint = <&r63455_right_in>;
>>>> 				};
>>>> 			};
>>>> 			port@3 {
>>>> 				combined_panel1: endpoint {
>>>> 					remote-endpoint = <&r63455_left_in>;
>>>> 				};
>>>> 			};
>>>> 		};
>>>> 	};
>>>> };
>>>
>>> This is an interesting approach and it would be a requirement, if we
>>> ever have a device with 4 DSI hosts which can driver two sets of XR
>>> panels (there would be no other way to understand, which pairs of panels
>>> are bundled together). I am not sure if it needs to be an OF graph
>>> device or if it can simply reference the DSI devices. Or if it can
>>> reference panels (which is not the same).
>>
>> I mean we could imagine combine any number of panels to form a combined display,
>> 2 or 4 DSI links would be handled the same.
> 
> I was thinking about 2 combined display example. In this case you can't
> figure it out in software without extra hint.
> 
>>
>>>
>>> Another question, do we need to list any other devices here? regulators?
>>> sensors? maybe proximity sensor? cameras? I'm thinking from the
>>> 4-host-2-xr point of view, because if we don't have 4 DSI hosts, we
>>> don't need to describe anything. We already know all the hardware
>>> properies and connections, the rest is really just a software plumbing.
>>
>> The regulators would be in the panel nodes, for the associated peripherals
>> like sensors & cameras they are not physically tied to the display so
>> it's only software plumbing.
> 
> regulators yes, they are described. Think about the 2 XR units being
> driven by the same "base". I think, you would at least need to link the
> cameras to the enclosure. Otherwise you will have a 2x number of cameras
> and no idea which of the enclosures they belong to.
> 

This is highly improbable, and I don't think it's the priority right now anyway.

Neil
