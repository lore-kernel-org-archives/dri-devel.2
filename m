Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316A3CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B7010EE1F;
	Tue, 29 Sep 2026 10:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BwrIA9Xj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7067810EE1F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1833341096;
 Tue, 29 Sep 2026 10:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D881F000FF;
 Tue, 29 Sep 2026 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790678178;
 bh=9bcgoUfHGt6s278k1vT7H9/x3Ltims12LpvHmOWcLnY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BwrIA9XjNjrnlXj5eQeJtGuLTNHD7PX8yNkE4cSSZDuZHWUfuzBgb+oFbFDkFDITK
 XEc7lmM8HIQwQYZuQgPeuHI/tUDtCGAzv0bxrY0IYm3oIL+G2gABCiV8mBn5vJ3eBW
 tcUx8BDS/s1RyQcNqhYG5Xl5xIAyJPYGMw/LgFVwcVNd5LqaKYNZi7N9gMNu1XDWdj
 bNbdy5W9nj8B70Bs1tx321qPozEhRRv4w+LB6gxLznPLFUmj6GHl3YyytGrBlMO5G3
 pyfjFIW1ZTdyq8B+fXipF92dTuTEwF5GI6WAdH40XsKiddEBFVzqLIOdHMsK0txpQn
 TmGs1aT72ut2w==
Message-ID: <ce6379a5-2a60-4d65-9553-e39f8398d6cf@kernel.org>
Date: Tue, 29 Sep 2026 12:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] drm/panel: s6e3ha8: Correct the polarity logic
 within
To: David Heidelberg <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <739ce9f4-8bdb-4bc4-9cc1-9a1a7eba80ce@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 29/09/2026 11:59, David Heidelberg wrote:
> On 29/09/2026 11:51, Krzysztof Kozlowski wrote:
>> On 29/09/2026 11:41, David Heidelberg wrote:
>>> On 29/09/2026 09:45, Krzysztof Kozlowski wrote:
>>>> On Thu, Sep 24, 2026 at 04:01:34PM +0200, David Heidelberg wrote:
>>>>> The reset was introduced with wrong polarity. Correct for the future
>>>>> compatibles and keep current with reverted logic.
>>>>>
>>>>> Old DTs keep GPIO_ACTIVE_HIGH and are fixed up via
>>>>> gpiod_toggle_active_low() on the deprecated compatible.
>>>>>
>>>>> Assisted-by: LLM
>>>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>>> ---
>>>>>    drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 23 +++++++++++++++++++----
>>>>>    1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>> index 5e1e997b83b36..99290913de69a 100644
>>>>> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
>>>>> @@ -20,16 +20,17 @@
>>>>>    #include "panel-samsung-dsi.h"
>>>>>    
>>>>>    struct s6e3ha8_desc {
>>>>>    	const struct drm_panel_funcs *funcs;
>>>>>    	const struct drm_display_mode *mode;
>>>>>    	unsigned long mode_flags;
>>>>>    	const struct regulator_bulk_data *supplies;
>>>>>    	unsigned int num_supplies;
>>>>> +	bool broken_reset_polarity;
>>>>>    };
>>>>>    
>>>>>    struct s6e3ha8 {
>>>>>    	struct drm_panel panel;
>>>>>    	struct mipi_dsi_device *dsi;
>>>>>    	const struct s6e3ha8_desc *desc;
>>>>>    	struct drm_dsc_config dsc;
>>>>>    	struct gpio_desc *reset_gpio;
>>>>> @@ -62,22 +63,22 @@ static int s6e3ha8_unprepare(struct drm_panel *panel)
>>>>>    {
>>>>>    	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>>>>>    
>>>>>    	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
>>>>>    }
>>>>>    
>>>>>    static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
>>>>>    {
>>>>> -	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>>>>> -	usleep_range(5000, 6000);
>>>>>    	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>>>>>    	usleep_range(5000, 6000);
>>>>>    	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>>>>>    	usleep_range(5000, 6000);
>>>>> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>>>>
>>>> This breaks all users and this usage of ABI was already released.
>>>
>>> See the gpiod_toggle_active_low() usage later in the patch which keep the logic
>>> for the original compatible as intended.
>>>
>>
>> OK, I went way too fast, that's correct part. But splitting fix is still
>> just confusing. Backporting to stable is a different thing than fixing
>> issues.
> 
> Sure, I already droped the previous commit changing it for stable.
> 
> Btw. looking at gpiod_toggle_active_low(), would it make sense to do a series 
> correcting panel reset logic? I see many panels keep "reset asserted" in the 
> driver (but ofc not in the reality).


To my knowledge it is impossible task to do, without breaking something.
Either you break users of ABI (so the DTS) or break existing users of
DTS. One could try to avoid both by using your approach here with
compatibles having fallback. But then what polarity actually would be in
such DTS node? If you know your users, like for some SoC components, you
could argue that none of then will be affected. But both the driver and
DTS here can be used externally.

Best regards,
Krzysztof
