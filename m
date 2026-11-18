Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659C606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n8Nql9V8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C9210FBBA;
	Wed, 18 Nov 2026 12:28:27 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59E610FBA2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:28:17 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so8599125e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004896; x=1795609696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sbg0KLhjP6VImCPLy3d1+inU/8Bcn6/seY59UQYwN7I=;
 b=n8Nql9V8sLL8rWOw6XLv+NajuzLCFYMbwWWe0EW1LcM/J9E31U5g+ikUDZvUgY2cuy
 uyeqZQxNafv0BXTDWOMWYQsPfDUd4Qy6ds95xFLYj4dnGNQn89dzl1Fe4uM+yjj4cKs1
 m+ygv0hjqD8pBfpEObTCdZ+/xI5ld5gzTL3RInE1l7a0kvGrlYe5bBo8a5R8KTzeMu74
 djb/l8NZf2xDNUfv/HdIf4ZPO+rPEoo2c6SFg/Fk7dx0oBHCge4lj9HTJQYu8GrIOM46
 mKslE64kXZP57lA5c1X5wym+S0LYtIJW/qu4KpY3NOXYLEf70pl6jegpfljY8yA7JfnC
 limQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004896; x=1795609696;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sbg0KLhjP6VImCPLy3d1+inU/8Bcn6/seY59UQYwN7I=;
 b=L0lnJ3idt0Rcvm0dGVPSLT2NQans0AM/OTOkMfRc9FXEyZetfvQus/amYVdKd0gRAq
 zKwhzAbnNb7DvC0NnwqWZbTfswTLxhMJ8CK3DrCT9gANzZd08wzJEnLTExMeoouhI+AZ
 hS3+fvesT7D7a/7XD2/B7HPbegkAEr5+4BDPpTmhmcIIf1Xg+q5oAzj19IaaiaFiAaDv
 MCs2dFlrhaE1Gd4qQGRQhw1YF9YDPbJECQNyBbnd6LsDTzHT871PepjyKZ8/lJpICrjp
 6rTuD0VWsq6bXhw7cqY1EsauXEbSIPF84JHYfoetLjO+lkWuexgQyTw5iup5HSdS70Zm
 kayw==
X-Forwarded-Encrypted: i=1;
 AL+hErEyWNPIik6R7q8A5JvR+ih0rBtUDEM5ZnFgLtX12mdv714ALS6b/weflDqLpTWY4CUpDL1xxQT8IlY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zVn2Huuti/cFRPVaEc5Piw61klCxm9n60zuwef5LzOJXIdkd1
 Inj8tlmP8HC/CSIRm16Gfvo0c3yZ7bK5KRw6FTPscqzs+5QtCvwCYZYPZjJCFtZkTt4=
X-Gm-Gg: AYBFou2msNGq8kPlR3Kk0f4c2po6q5QILQW0kM6PxWe2TRTfe0vjjNnHxPQALioN6IU
 mXo15pTbBUKRy0s3+2AH8J7njwJ7IVg719w4I4hU831gmaq5xJOczm3P7tA8afexWOIia5n196y
 34Z79oAO1xdgCQGCT6GyQcPTxe/W2uKdIA1zDvjzcay+MS1v5JRW0PyvUnM85F3nKVCbn2gtxg+
 znZ4s+TFXrIJ8QXonuJdBLleE+8FQjlBwijx7IKxXOtAifkI26CN2Q4iwUwKB6CegZuvDW0B0F0
 telh4mAjCBx1x4LqBcRuze2kyi1ZuIehwk92jTv9uDOzGlf4Krt76y2z2wSU9iTuKzrBPwpiWSU
 Pcyn9ATQbkV5EGJlxo5pZSb6O5Q4juQNcrajbi88tVbBgHzP2mtza6WNAF3qlo+4fHX5B+y8PT7
 ZEwe28wwgQ8nRlRXOsj3bBbXgxA6rGZwxD+ic0w+/G2jTXYP7LByDsA9xkKwxTprfX+VvKEuzjX
 hjiyQKuukha+izmq7nBwQZkr9JaP9h3xigYmvlLPInfPKGS19u359TcCggoJ03cVWSXN7LO8b2g
 M3WxQZx3RQT+q0UUD48tjckg4OwGPLs/XpxUvaoWdGriaVKsp8nxZCyT0VN6wFIRzcVsrKJtnC/
 RBw==
X-Received: by 2002:a05:600c:8b63:b0:4bb:6871:8f21 with SMTP id
 5b1f17b1804b1-4bb7da27fd2mr44906275e9.23.1795004896063; 
 Wed, 18 Nov 2026 04:28:16 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2abfc4sm64858355e9.7.2026.11.18.04.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:28:15 -0800 (PST)
Message-ID: <6291be5c-94e8-4a5b-aa30-f797672e4165@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 10/12] accel/rocket: add a GET_PARAM ioctl for the
 hardware version
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
 <bd963b70e40af3c3c74ac1569cda7be885b0ada1.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <bd963b70e40af3c3c74ac1569cda7be885b0ada1.1794615323.git.gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> Add DRM_IOCTL_ROCKET_GET_PARAM so that userspace can query the NPU
> hardware version and pick the matching hardware description, such as the
> SRAM configuration and the register layout.
> 
> Add DRM_ROCKET_PARAM_HW_VERSION, which returns a hardware version enum
> that matches the device tree compatible.
> 
> The enum starts at 1 and 0 is not used:
> 
>   RK3588: 1
>   RK3576: 2

I wonder if REG_PC_VERSION / REG_PC_VERSION_NUM could be used instead of
creating our own numbering scheme?

> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
> index ef7043046bc6..50c8b05bd394 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -41,6 +41,7 @@ struct rocket_soc_data {
>  	unsigned int num_clks;
>  	unsigned int num_resets;
>  	bool task_con_16bit;
> +	u32 hw_version;
>  };


If we're adding hw_version here then perhaps the task_con register
selection could be made based on the hw_version field value. Then we
don't need an extra flag.

> +static int
> +rocket_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
> +{
> +	struct rocket_device *rdev = to_rocket_device(dev);
> +	struct drm_rocket_get_param *args = data;
> +	const struct rocket_soc_data *soc;
> +
> +	if (args->reserved != 0) {
> +		drm_dbg(dev, "Reserved field in drm_rocket_get_param struct should be 0.\n");
> +		return -EINVAL;
> +	}
> +
> +	soc = READ_ONCE(rdev->cores[0].soc);

Does it make sense to do READ_ONCE if the variable was not written with
WRITE_ONCE?

If my quick read of commits like 89c2c777df17 is correct, it's possible
that there are gaps anywhere in the cores[] list; please double check if
it's safe to always assume core 0 exists.

> +/**
> + * enum drm_rocket_param - parameters for DRM_IOCTL_ROCKET_GET_PARAM
> + * @DRM_ROCKET_PARAM_HW_VERSION: an enum drm_rocket_hw_version value.
> + */
> +enum drm_rocket_param {
> +	DRM_ROCKET_PARAM_HW_VERSION = 0,
> +};
> +
> +/**
> + * enum drm_rocket_hw_version - the NPU, one value per DT compatible
> + * @DRM_ROCKET_HW_RK3588: "rockchip,rk3588-rknn-core"
> + * @DRM_ROCKET_HW_RK3576: "rockchip,rk3576-rknn-core"
> + */

Let's not document these as a match against compatible and their values,
just state it as a way of identifying the NPU chipset.
