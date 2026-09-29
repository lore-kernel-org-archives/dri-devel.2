Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688ACA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66C110EE89;
	Tue, 29 Sep 2026 12:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="AbXarkRI";
	dkim-atps=neutral
Received: from ixit.cz (ixit.cz [84.42.129.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBEB10EE89
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:12:57 +0000 (UTC)
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown
 [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 4CFA8534030D;
 Tue, 29 Sep 2026 14:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1790683974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YIcJiMvSHwtCZnraYE7wCGLbPbIrNhutTgj56ANQtZQ=;
 b=AbXarkRI7d1uL5pGMTN/5au3nH00ZVes00ljfBw59yD7Qjr/1kIgkQsn4S3NDsbaTe3pvc
 86+w92S4SwvByTCCrF4jbvLZiJfCP0dDiAhaEY/liQAN7VygMySW4NTP2w1kHORudDHOGV
 yCikEM0v8ls11Lr+17vkgfM8U2yy1RY=
Message-ID: <49805bcc-2456-4f7d-a08a-3ccb7223ea50@ixit.cz>
Date: Tue, 29 Sep 2026 14:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] drm/panel: s6e3ha8: Correct the polarity logic
 within
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-6-08d5c7bf72fc@ixit.cz>
 <20260929-dramatic-ocelot-of-support-2aa377@quoll>
 <d1183441-ee4e-4700-90d9-996769eaaa11@ixit.cz>
 <b7d5d018-116f-46dd-b037-4d46c25a8435@kernel.org>
 <739ce9f4-8bdb-4bc4-9cc1-9a1a7eba80ce@ixit.cz>
 <ce6379a5-2a60-4d65-9553-e39f8398d6cf@kernel.org>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <ce6379a5-2a60-4d65-9553-e39f8398d6cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Yes
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

On 29/09/2026 12:36, Krzysztof Kozlowski wrote:
> On 29/09/2026 11:59, David Heidelberg wrote:
>> On 29/09/2026 11:51, Krzysztof Kozlowski wrote:
>>> On 29/09/2026 11:41, David Heidelberg wrote:
>>>> On 29/09/2026 09:45, Krzysztof Kozlowski wrote:
>>>>> On Thu, Sep 24, 2026 at 04:01:34PM +0200, David Heidelberg wrote:
>>>>>> The reset was introduced with wrong polarity. Correct for the future
>>>>>> compatibles and keep current with reverted logic.
>>>>>>
>>>>>> Old DTs keep GPIO_ACTIVE_HIGH and are fixed up via
>>>>>> gpiod_toggle_active_low() on the deprecated compatible.
>>>>>>
>>>>>> Assisted-by: LLM
>>>>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>>>> ---
>>>>>>     drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 23 +++++++++++++++++++----
>>>>>>     1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>>> index 5e1e997b83b36..99290913de69a 100644
>>>>>> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>>> @@ -20,16 +20,17 @@
>>>>>>     #include "panel-samsung-dsi.h"
>>>>>>     
>>>>>>     struct s6e3ha8_desc {
>>>>>>     	const struct drm_panel_funcs *funcs;
>>>>>>     	const struct drm_display_mode *mode;
>>>>>>     	unsigned long mode_flags;
>>>>>>     	const struct regulator_bulk_data *supplies;
>>>>>>     	unsigned int num_supplies;
>>>>>> +	bool broken_reset_polarity;
>>>>>>     };
>>>>>>     
>>>>>>     struct s6e3ha8 {
>>>>>>     	struct drm_panel panel;
>>>>>>     	struct mipi_dsi_device *dsi;
>>>>>>     	const struct s6e3ha8_desc *desc;
>>>>>>     	struct drm_dsc_config dsc;
>>>>>>     	struct gpio_desc *reset_gpio;
>>>>>> @@ -62,22 +63,22 @@ static int s6e3ha8_unprepare(struct drm_panel *panel)
>>>>>>     {
>>>>>>     	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>>>>>>     
>>>>>>     	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
>>>>>>     }
>>>>>>     
>>>>>>     static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
>>>>>>     {
>>>>>> -	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>>>>>> -	usleep_range(5000, 6000);
>>>>>>     	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>>>>>>     	usleep_range(5000, 6000);
>>>>>>     	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>>>>>>     	usleep_range(5000, 6000);
>>>>>> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>>>>>
>>>>> This breaks all users and this usage of ABI was already released.
>>>>
>>>> See the gpiod_toggle_active_low() usage later in the patch which keep the logic
>>>> for the original compatible as intended.
>>>>
>>>
>>> OK, I went way too fast, that's correct part. But splitting fix is still
>>> just confusing. Backporting to stable is a different thing than fixing
>>> issues.
>>
>> Sure, I already droped the previous commit changing it for stable.
>>
>> Btw. looking at gpiod_toggle_active_low(), would it make sense to do a series
>> correcting panel reset logic? I see many panels keep "reset asserted" in the
>> driver (but ofc not in the reality).
> 
> 
> To my knowledge it is impossible task to do, without breaking something.

I would do the partial change (only driver, not full DT).

So we end up with drivers having the correct logic with extra 2-line DT quirk 
using gpiod_toggle_active_low() for given compatible.

This could solve people implementing new panel on top of existing DDIC and allow 
them to use the right polarity for new compatible.

David

> Either you break users of ABI (so the DTS) or break existing users of
> DTS. One could try to avoid both by using your approach here with
> compatibles having fallback. But then what polarity actually would be in
> such DTS node? If you know your users, like for some SoC components, you
> could argue that none of then will be affected. But both the driver and
> DTS here can be used externally.
> 
> Best regards,
> Krzysztof

