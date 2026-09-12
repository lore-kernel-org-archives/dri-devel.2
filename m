Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C10BC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 18:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6374410E2BB;
	Sat, 12 Sep 2026 18:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqQnMzmd";
	dkim-atps=neutral
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE0D10E2BB
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 18:19:09 +0000 (UTC)
Received: by mail-oo2-f4.google.com with SMTP id
 46e09a7af769-7f4e9ec63a7so382522a34.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789237147; x=1789841947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7VGIYZo7HUmxuRC6xiRDT2Kb9by85XHCuXQlDG3DRrk=;
 b=AqQnMzmd0oQrA/EQx8/aHR5GYxltu76xloZ2yqKt5Ohr/kGsLCQR7GzvC/2P90cw7j
 qowwa1MbWM4zRyHmuXSHlWQPhQIa4dWQFFZMP9zu65+i0/Ur8ww1Ey1/EZtme6kHl1W6
 RG7ryLIz2WwclHg2XN6q9GyXlAnYMM+MyZo8LWW/ELN2rAZgv7BnhTkEnMYpcvseATVq
 O0b+WPQxsvsTIaDj1Zll0ZtLBgATiiQuMrERWhArXOO5DNqJR6LnyxR8HCR/NPObW4UV
 DVkmhJLqyNmt0F3ALiVg2ActXKOKR4lm7vMHfOR3Eqciw0N7wSN5vQCmQLCzd0BCD72+
 o8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789237147; x=1789841947;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7VGIYZo7HUmxuRC6xiRDT2Kb9by85XHCuXQlDG3DRrk=;
 b=n18Rrz7ZedGv9j6phLrifSqilJ+tYeWUinkPy/rdFKncwfwUaZyKvRfz4cQcaCxPwZ
 4YYRLxm11Jq/y/cwoHuArt2WeLMH2VHOiz/bmuJ1S34G2ABDmQ1BooN7ZKqiO+K0W1jJ
 nvY0Pgksb5uZGs9GS0xO9hqWu0moKpt1n0WQ/3T5gUV9R5nR/FOVRaW9R7h0GOzvr/76
 8pwTEzBVXeRduJkWourMwtXnhVgfdYqlzmDAqR3GXb995KOuefa0h0pkBFsWHFcqf5EH
 fkaFU7Z6xsoxDJIAMCbLgxWGUikbsD/n+PZy9Lmsgh4ZKMr3Wu/gQzzm6h7SM9qY/X85
 cLOA==
X-Gm-Message-State: AFuF++mEvZ/EJrcmfljWqHGMQ9RNhlEQP9tqIu1Y1xySHnhe7eOqwvoW
 v8aMzG1B2kbGjhBJnMAY2oAyJ3gO/Rdyr8WtUFTSesrhji8FJXx0upmt
X-Gm-Gg: AYBFou3zdu7QSFFYlXaRmSLS+LO7VIzE1L02EcDZYI9n2YeZxhW8Ee8L/j3Pz9Kstk5
 Mzp03x16f+8h0ZSKukvheiaOP9ZKLUQfhosMBSiEtO2t/7co7G0yd7cxInnO4IMB/QgSpYXCoFj
 lMMLLl84IscYxEL48X9GASuZRKGBrQ57+/ViSPHQhl6r7oV4AkzVEH7pPW83AnWi1wUmYJQHe/E
 1bFJHaSK99aDatLMI6Y9wkkel91YXkjxMj6JVJyFY75CuL9qNVLmU2C95ah3ZYYuU6zMKZPIhVc
 ivMNgLyLQIHet5zZIjuKk3yxrGVMY7u7QKHa9vYEiLJ4Vkz2dw621XE6uGqRQD13KrAO8sQZUzt
 0KWjTTCKvUis+qc9O+fXk1dVSJ6UmSD4E9RLyIlcCtiIHchJ+xVctB9fMKhelFVNR78xiScZVQt
 fKLm9WnwBGVBJyLzn8xNEigkNNFFwvntA3bD7PjXl8NoriqSKpljLWqO/rR37zAK4kZVwccmj5m
 CYczK2wth7YJlhx
X-Received: by 2002:a05:6830:6d44:b0:801:21a3:f304 with SMTP id
 46e09a7af769-805a0c42350mr2098949a34.20.1789237146911; 
 Sat, 12 Sep 2026 11:19:06 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f60fe54asm6787312a34.15.2026.09.12.11.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 11:19:06 -0700 (PDT)
Message-ID: <a214e0d4-b25c-4606-8a46-6a697cfdb1d0@gmail.com>
Date: Sat, 12 Sep 2026 13:19:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
To: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
References: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
 <56dcdf77-2a82-4efc-888b-736f512e63f5@gmail.com>
 <6fc67e27-a36c-4974-96e4-1f68b85b3114@mainlining.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <6fc67e27-a36c-4974-96e4-1f68b85b3114@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/12/26 7:05 AM, Nickolay Goppen wrote:
> Maybe I can incorporate your panel to my driver. 
Ack, sending out the patches on top of yours now. Thank you!
