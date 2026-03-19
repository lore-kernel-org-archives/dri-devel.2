Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8753F1088E65
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31FC10E806;
	Thu, 19 Mar 2026 02:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGtWORBx";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FEC10E806
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:37:29 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-82a124f3a5bso118232b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773887849; x=1774492649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=41gqP9Xz29ZxguAd8x+A60goY3aYjFU2+iS4d14MjxY=;
 b=BGtWORBxkmLAybbWwLxCHBpE3I9+Uk/s4df95zy8L5WlX2QEyW4GroRHrMh0krkrdC
 LC1Qe8wboMetUpAYjyvJmjblxUIRSns/RmSAj4oN3s9EV32BosKvCYcdyAI3bedegTXW
 Fuv2ZMZT0OKAcgydaxnrwbohGrmPoWXrL6P3rOyG644KSafQTvAC17EFed0hiiKhf0NL
 oF5rrjvcGUnlOlSRSpWzeaWZkCaO9x0/gm5argl9a/AS6+YiinwdkeNsOQ7KbNkvWKet
 8OQUmiuaI0lMOMEK9FI/m0gmUKEbHX1ToSL2EtwU0qCkRcprw3j7d7N5iS5mftRQwSw7
 4o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887849; x=1774492649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=41gqP9Xz29ZxguAd8x+A60goY3aYjFU2+iS4d14MjxY=;
 b=GUn2Y13YU3klHkTUGlBPi8KoTxCymmCDhE7yBWgC4yei/D49S/QRPTOlTmt+hHOq6H
 fQ5iyXd31gLmPQUfmtG1cGuxsaMCuPeDHjS5Ae3lRNLQSsnEXPnLwynUIMJdfkOF8pdD
 OWL0J8O4P+SAe791fDedV1BrFO9OozxcfyEP3GNF36motDnOQEvR9XrlgJHvOx4oD9Yr
 aq2b3/GlFgM/Q8H3Mxpvk//cCuWEaLfA81TMj7qCWneZHMWSZtlp41HKPnbNAqu1Ehwe
 seOJNRUjrAbAvQ041cC8sQOLmL/H8+rgRBYoD+8hBxT9R4s92nVJg0acrSa/7QEyS/P1
 NJXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9t6oxR5AwLTsZqeLsdOFTWRzKfbMy5z8k8jT9tJPu6hIxrfYpJjUjzr2HTplyAWgtQhwwoH+iPOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD/9EIY0y2odfZEglTtB2DNHN3XawebZAhoE5s4+IZu6Wa4SXS
 V+pZnk7LFpnYreEwXbGv0miHHInoNK/UwRJtBZbe18mS2r+AgMo4upDU
X-Gm-Gg: ATEYQzwUdHSwKWpJMLw8kSeFyCYoktFfrr+aSj3ySs1SHa2rYC5bQAdEoqbyxB0XRFv
 aJiyOc5oFPvWWktnmyjuvJjzIOWDg6r+J1vVpj7mKO560Da6JyXI87x8AW3GUbPs50H1wP/2ATa
 VDIQYNecFl3L2ULczpXuDjpYRUGABem1lw9D4dsqU3Tl0pr72AWmrDgeGwVsPvblC89CqK14uI/
 MkDtpC9rCLGqqqXSoih8/p0MFzv++nx8RTgWl8gdqp0BFaOEKPmInjBsFladrJw0lTRepfx3x/m
 6onrAnWh/NMi4z4/qcJqfZRTgDvKm3EfBMPTcHFu9ml50Tv7PCbVGMxWl5KcXtk958s2DFhJlSU
 2RL9eeREvHlKcWMKecWkXpJQ7BS2qydk5n7DWV8hEPE/aKtHC8YOjs447tmSJGqTegCRmReIgi2
 exLXnIN+iNwSP6JDudNqgvqn5szOASyHFPNTiR9EoBUOAEpr+jzS7e3CLRPqnRLV5ovIrSG/ewF
 JfcXThj8Kbg8j20rxSBskaKDL/ulAAnzVPTEkhqiO7f8jh+agc6JENpnTpaP7AEUNFviL0RBXPw
 VA==
X-Received: by 2002:a05:6a00:6c94:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-82a6af3c066mr4829584b3a.49.1773887848851; 
 Wed, 18 Mar 2026 19:37:28 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:9662:a5ea:aac3:575e?
 ([2601:1c0:5780:9200:9662:a5ea:aac3:575e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b541cc7sm4196785b3a.6.2026.03.18.19.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 19:37:28 -0700 (PDT)
Message-ID: <3b018af1-15d7-4bf4-b567-2692656302e0@gmail.com>
Date: Wed, 18 Mar 2026 19:37:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Convert to
 mipi_dsi_*_multi() helpers
To: Doug Anderson <dianders@chromium.org>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260305044921.10942-1-chintanlike@gmail.com>
 <CAD=FV=UEX1tEvNLVmrkF4AWzbGJhmH9_4vM2255ufVjKkrVNdg@mail.gmail.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <CAD=FV=UEX1tEvNLVmrkF4AWzbGJhmH9_4vM2255ufVjKkrVNdg@mail.gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 3/13/26 08:46, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 4, 2026 at 8:49 PM Chintan Patel <chintanlike@gmail.com> wrote:
>>
>> Convert the driver to use the non-deprecated mipi_dsi_*_multi() helpers and
>> mipi_dsi_msleep().
>>
>> Switch DCS command sequences to the multi context API and
>> accumulate errors via struct mipi_dsi_multi_context. Replace
>> open-coded error handling with the multi helpers and convert
>> nt36672a_send_cmds() and power sequencing accordingly.
>>
>> This patch is intended to functionally be a no-op, though there is one
>> slight change. Previously a failure in regulator_bulk_disable() would
>> have caused nt36672a_panel_unprepare() to return an error. Now it
>> won't. No other errors in nt36672a_panel_unprepare() were propagated,
>> so this makes things consistent.
>>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>> ---
>> Changes in v3:
>> - Keep local ret variable in nt36672a_panel_power_off() to preserve error code in logging.
>> - Change mipi_dsi_msleep() back to regular msleep(60) in power-down sequence to preserve behavior.
>> - Reset dsi_ctx.accum_err before set_display_off_multi() and before power-down to preserve original error-tolerant shutdown behavior.
>>
>> Changes in v2:
>> - Address alignment feedback from Doug.
>> - Restore original power-down ordering.
>> - Drop return value from nt36672a_panel_power_off().
>> - Consolidate error handling around dsi_ctx.accum_err.
>>
>>   .../gpu/drm/panel/panel-novatek-nt36672a.c    | 94 ++++++-------------
>>   1 file changed, 30 insertions(+), 64 deletions(-)
> 
> Pushed to drm-misc-next:
> 
> [1/1] drm/panel: novatek-nt36672a: Convert to mipi_dsi_*_multi() helpers
>        commit: bc4cb68a02f1a445aa65d8054bd69ba4ba3f5767

Thank you Doug!
