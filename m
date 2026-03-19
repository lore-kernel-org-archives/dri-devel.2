Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6DF1088E66
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C74110E809;
	Thu, 19 Mar 2026 02:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdHOeNlD";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B1710E809
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:40:33 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82987437624so291583b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773888033; x=1774492833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBu63CJPO7UWTxKfklYPpnd3YM/gcmd39X2brzmYCN4=;
 b=hdHOeNlD76iyqcr6XqJ7bZrgU5BGoXc/yMSKpF+T0votLUgRKjVoYAUsXFkw0mSvtE
 wotmiKBBiR4es+gTUkNql8ELz2XACRTwIFUnt8/DgonGI+SfqyfgbTWzRdzUCEK0MdLj
 S3usxOlJSkQbma5Spo59UltO1M6XfGpXTI6F0AP20VNYJprexskPkxlDrhvT7Ryj5YsW
 PPQtrgaJ6x/HEHPMGpYjw+SxILo0UB7bbk8n1H1fqcvnoI7rhUNMbEzEpM95VKlgSmCw
 8q2CQQsjScQFRjmI8XyttJHZj8uDqwZMqQBIuR2JIXg1jEO4I7bljRIRR14jPkdEn2q9
 p4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773888033; x=1774492833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBu63CJPO7UWTxKfklYPpnd3YM/gcmd39X2brzmYCN4=;
 b=Te8OOy7XBhMOcfgyU1bpbCrZMN0M7ZB4eF2d43yJ7j7iQZTrELURUDrvomuqZgvHsA
 3UtaU92JF6MdDJ/aTS3ZReLGULZDmpwYvTlE5BX7dODZ4p6Iw3VLcKr3aDRTPFL+i+Ld
 +6un9lJ/Xa68+mGRBxvSlYB4y+9w5xLWJM8hB3/vHyiqJns78B0wRzZs+V4jIg3F5jge
 1BCdHYeA/L4CvFq19VVOXszQLUVRMIqOZp7ADQDVSLCUb3xoroKTpaQNwxMRbA9QlPPv
 L5hzrPis5YJpeXh3l5VHl01E51pb5wMKdoBWc/pJhRHBEgmtYbti1cAuqvFDPIhnLq9T
 W9/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBGyJS4oqTa+yMWApDhjudZ/nwH+xY8ywx1nRdI9xDTrQtnpaTPpX7ra9seck2kLe9dnpowoi08KY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+Uqly6fWOtCGYclTBqhVWOioAtOrG7+GIS6PE3XGHI5IkRRMD
 iuFiohOZiBpkmFuq2+VIHZLA4D/umebMAA2YQ9STd30eaSY/SRat7A0a
X-Gm-Gg: ATEYQzzVidmPxIQyQxJ2ltm349P/9V8uq0HYscrhXM1vFVS9ZhoecfUbtKO+YtGgp+D
 XBE6mdYgXz3PzTefLmLr3zvSSquLYSgSfOyrEN+TXZyUvXhG7G4rdxUYKn0j/RWbgkzRR0r5ats
 URlrTg9nC3w7NX5d2sDZQEg4A/FIeG+sAhMnIzCoYfIZDtZQmbYjneeABPnBPctSpppRKT6NDUH
 onIeUlj7V6j6iA6o8hpgozxhdzNo8I0Et+pAwI6QyVzjtiliMXgn6dbuw7wJtDZbmwb2MbWctQH
 jfOgOdD7EJH2dHv6duTY2oGu9jYJssd1aaTyxfaXjax+uh8h+Vsrnb4DACa2lRGfhRfLxvyd8/7
 FgkFNG0xvanF+Kmq72ebaz8aBbppcrTFXDVaiSTQNOtnyYsbDGQSxEImL9l7gh6hXXh59D8jtK3
 K/4oV4i0SnqVMyQ6s/dC56NS9/6y9SwzJtdzwsRB6Q3bgkl9ZxUZZYjbxKh5w7k3fXKcyeVUm1X
 cpqd5TXCHBzrQbAIUt2CWvmK45f6wyY2SxqQhzlezbYEg648mGwXKHDZ9JqGVyHA9y7R+U+rDWV
 yw==
X-Received: by 2002:a05:6a00:ab84:b0:829:8083:472b with SMTP id
 d2e1a72fcca58-82a7a7ffad1mr1502135b3a.4.1773888033409; 
 Wed, 18 Mar 2026 19:40:33 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:9662:a5ea:aac3:575e?
 ([2601:1c0:5780:9200:9662:a5ea:aac3:575e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe1869sm4874011b3a.40.2026.03.18.19.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 19:40:33 -0700 (PDT)
Message-ID: <18f74625-5f97-425b-8389-17d1bbecd4ac@gmail.com>
Date: Wed, 18 Mar 2026 19:40:32 -0700
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
 <CAD=FV=WMKjA3eRhZyHd820BFBYUMfz_=F4ppNYPWDEHKwiORXA@mail.gmail.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <CAD=FV=WMKjA3eRhZyHd820BFBYUMfz_=F4ppNYPWDEHKwiORXA@mail.gmail.com>
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



On 3/6/26 09:40, Doug Anderson wrote:
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
> Looks good to me now. I'll plan to apply in ~1 week if there is no
> further feedback.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> As per my response in v1 [1], someone could still do additional
> cleanup to move away from the table-based initialization, but it
> doesn't make sense to block this patch on that. :-)
> 

Agree - I have plan to address as separate patch.

> [1] https://lore.kernel.org/r/CAD=FV=WtjW5WWmjeb2zwF2PjiJeZv1jZS_UKZ0bT1658=CkwVA@mail.gmail.com
> 
> -Doug

