Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E360A260D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mBiVimyn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C9D10FBD3;
	Wed, 18 Nov 2026 12:28:03 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D91510FB73
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:27:57 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-491846221ffso726028f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004875; x=1795609675;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pWhnfvWenZjOfquzYUSnlcmZobUEBcHEFf7Qs3x3jIo=;
 b=mBiVimynjSyzB6ft1Z3t2/nLVoONZeurh7D9XKV09fr31fKWcqbPehViIbRfARRHWA
 iTSeOXUOzeXbtviKBoSZs5cH2zYXrNslYRbBnWakc56W2M82mGySVne5VWSPbq6Es3IJ
 G8+sUtZ7kOOLGxfHeK1kCBuuP5T6i7ky5wBBvBPB5NKRMkVV9wmA50GEd2Y9gmT88c++
 fRDIaYWddBgAocfi/CHirjJ8xggmxKWLphvuaH4QvRmAKFbgUHYB8cn1TRU3ybAmrZ07
 mmBy7x3aOCL7aFLQyE5mfxMhr6oDbdu94s/4etVmSF4fstxDjfTAIc+LNqF1h9YzDc8B
 56Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004875; x=1795609675;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWhnfvWenZjOfquzYUSnlcmZobUEBcHEFf7Qs3x3jIo=;
 b=UsxaWPU5SdqyzSv6aJZyflX+GoLfi1/TElpxQGI5/KgY4Cbg88rB0C7oj0B8OlxcIv
 uN9PNjXSTUa+BpyzZ0ehBMzBvQ8py/WIcGU41uvFtLMkxzlvd2S/UqC6jJYn2/+GUYkf
 hMsGqk4wnWEYfUj+Z3Ntu+Lei9kJxvc+s1OEU+98RcqvyXPhYD3bM+i6gA5KvdhGgMt5
 Ipy4INCtdGo6XsarHOBpLbv37UXDRar9+op5UYs47tQ5cSAT9BgpQTtywxr8GsbJIuRd
 3JBua9hjhGFBCfaaFtlbqOexnlCcj1714Bhl8+ffDC6FQ6q5ME2SIvfWruyHwPj8Y4P0
 US2w==
X-Forwarded-Encrypted: i=1;
 AL+hErHnqeYuHC7DidlXQnsTDc5ZGTs86JBad5KnTsl+XeCQhyqOxYsVkm11pZ9gyZebwsJE4PrIxZyXwWU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9VFH9omE6CNtiSAkF7jWUOkeoP+98TJvSGekpFP2/fRUgJy5nz
 Ru4CN6OAJ+VOZgO2nt18Io76ytwWLeYnzV09Lnorcu6GTDL2MR/nalSlu+l684qShPI=
X-Gm-Gg: AZFdTZcwx3xSRqBJb1HFkIZNhe/IqJ6SIU+tTixJ/2eWkbeirKfST6WhGRMd3vMU/DA
 Q86zpeGfF/xuqes1PHT3Lx4cKIGXd/CZ8dXMzHEeR61OqG1pW+oraDX+uh9YEN51/l+wVPxtjH/
 PiOqrNkOyfYAn90i2/Zc702Y2VKQX8/yyNZl22enoyQ3Tc994DJddsWvSGAuUhWiFMGAMBnqris
 Ey1Azm+QnhkEiy092LkVSEvHm/3gkBM2BsCaZHl3gj1xrRyiPQkjArEzWslkA1txcS8Xk9V6uWi
 dzzPo5bdvJJkYMcU7NJixKZIeb58+yHrTRtw+U7Fi5GU/lcmQMWw67icTl+U2R7lyLFT/8AiTWY
 3OJbY0mJx0+rAVal0BgAc+DwtgLhecuU+gr3p5gRWA+2Iaeij99RemY/WiUUo0Y3c++AqGkeN76
 a6aJC4w7t7xT9Kg02y0Rr5LFFJm8bTJcZ4nMfmDy0dNEFwrvJohQoX9d66NnY6KBoI1CGrChy4u
 FH0sn85c63Muh2d3hx4j7gDP5L4FPjpqfBOq0NnMKYr+0kmb8sbcboWzpT36xAJ8QihucIU7l1w
 rTQosDpPd5dPgTLWrE/djW6BXqMzzW7oeI8fm4E0/k6E3Jl5nyXK/vp7dTK6q4WQDAR/TL0TqgL
 O5GNh9BUKbpPpnWTvK8zyk+o=
X-Received: by 2002:a5d:5d0f:0:b0:4a7:9630:7b32 with SMTP id
 ffacd0b85a97d-4a7963080d9mr2359433f8f.46.1795004875475; 
 Wed, 18 Nov 2026 04:27:55 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655f9f4a7sm4675322f8f.34.2026.11.18.04.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:27:55 -0800 (PST)
Message-ID: <0bcd84bb-6a87-453f-9b68-04dfa95f34a4@baylibre.com>
Date: Wed, 18 Nov 2026 12:27:53 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 08/12] accel/rocket: select the per-core clock and
 reset counts from match data
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <fcdd7117d3d7fe99ea1658c39b6d1a05428823f4.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <fcdd7117d3d7fe99ea1658c39b6d1a05428823f4.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 14/11/2026 03:05, Jiaxing Hu wrote:
> The RK3576 and the RK3588 use the same NPU block, but with different
> numbers of clocks and resets.
> 
> Take the number of clocks and resets for each core from soc_data in the
> match data, so the driver uses the right count on each SoC.


Rather than these clock and reset count rules via soc_data here, can we
just rely on the DT validation that is almost equivalent?

Then we can use devm_clk_bulk_get_all() and
devm_reset_control_array_get_exclusive() and not worry about checking
counts and names within the driver.

dtbs_check will already catch cases where the wrong number of clocks or
resets is provided, or where the names don't match the ones expected in
the bindings.

>   static int rocket_probe(struct platform_device *pdev)
>   {
> +	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
>   	int ret;
>   
> +	if (!soc) {
> +		dev_err(&pdev->dev, "no match data for this device\n");
> +		return -ENODEV;
> +	}


Since this would only be caused by a programming error, no print is
necessary.

