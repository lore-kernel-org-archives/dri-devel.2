Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168B606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ALXYiKRL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6158610F3DF;
	Tue, 24 Nov 2026 09:34:55 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B8C10F3DF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:34:48 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso41413815e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795512887; x=1796117687;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dzlULNiaNZ0xXGdWA1rlfP/03H+C6Hi4qgErNRy8s+Y=;
 b=ALXYiKRL3AsL2pYIev3UIIx2BJEvVJzm7xa+VKtFetqb0OEsSW7lrXHQ5zWQFkFVtT
 W7svLf8IEgvkvmx0FzLazkfd25MmArbkSETiZJarkyaYVG58SSu7CgxfUoK7eug0aV/k
 jc81f5EMViUQZyP38SODcre7GdIcntM3vWMJlq03wuuBONRpcW9kpcBXQO3w4Cj5lEUy
 RMk7jXuV0mdi9OXaCLP4u5pW/SDZMlfr/M7qt0s6Xej67ryS7P7jzfLQBoETdv10pO4O
 AhKU0+hC0Me43L7NiaXdWosJKr4j55zt6c+Z6enOWCv50dKzvX8ENu8plnT4pATW42Zq
 JiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795512887; x=1796117687;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dzlULNiaNZ0xXGdWA1rlfP/03H+C6Hi4qgErNRy8s+Y=;
 b=Ey34ARMT5tx68irBXv8unzntgxbdQkXlX0loRkTaT0ypmefKZSNYZTdMhjiimY1JUq
 F06tJQubLL3+ZGGJ1uEWA1K3x4WkZKK/yjmLy4aI9PywviD4DT0/cYrMNK8lTrsIZJMI
 iCqBISA7tzyW37jTLxY2+vTtWcfGeRGp5vVhWKtuXMFACvAOropq5aFApgHHJMIMRavh
 ZaSs85SPitdovJdjrAR8ibLPMRMB+MBmZXHlqpv1e1JiSJDWCtk+m4px/spVH5PVFRWZ
 K9VpqE4dJxLqjbWeNS571a9IPA/rxnE+LSSR8R3vo1j5pMvaFQcWKzLWlVjWNcDXRc30
 zaCw==
X-Forwarded-Encrypted: i=1;
 AL+hErGGg2pxgp8w00/m259pkRqStydVNDgnh01E7pxE3UvFNEVcCuO/ZfDKFVU2npIl06m2Nc4EHjdSsUU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BJoQ0Yg6a46d4TpssdREbsGZ1XsvPQ85fLmM0+T1chwpBNqkq
 1iXs0Qx88UJyxC+6gCpmf6s3Tdl1W7+VrGmrm2SgZHQD9tUh2DrjcWWA6KzIMt7e484=
X-Gm-Gg: AZFdTZenNjt9LxQU3AEXt23PL19aP1R80VwkgZCE0P/Quked4nsPvKc5wwJ8yZuoXrD
 /Pn0Q8h6bA7zqt0CRlsM1wKrCWCdPq4cEYZoYpopWXENXGT4ANZLZoV/LKt8UjkEyHqL++JWjaO
 SgztO3UmxplO/AeQeXu+mqHvQukNwKHm0kB5XeeEy7F9UQKC5o5XpKvhNNqSm8utAMcTRyQlMBV
 zoeyRSCUyiHZ0sY1zAko+JEviVdqqJsGbOLJgHbRx0LQROfR+RJZKT5vPvwDo3JC3WA2PJRkgYB
 mNWgGo5xolcaDEUVjJIqpVW53R14nuACLKUKkkyuRdRkucjGi5I9ijl+ctzYrGJsOuEpQsDFRQl
 FtsM4CNwOgPvBTa0OqJ9nX72bwsJrEyRV3e8VQ0r7Hv/Mp4p7HRskoWjV7pVaiF2N039x1ELExS
 bJYRaS9yn/vW3noTJhUCq+kZqaC4j6Yf8k7+Y0No595Fk4eXxE5Y8iv+UcxbZPg7ATt9kCg/HlM
 KzMqs82udsd59ArI40NNQZ9U34zWYyWW9eUHGhr7xAJrcca6hR+HQDThavxzdAZJ18YKeescbkU
 OS/TgvbutAkjfLuZnbERv++/wPLTo/i/KwZ1BMSr9Tk6jUxFMYGRoVubdXpfWU4Nc6Z9u29UOej
 kmQ==
X-Received: by 2002:a05:600c:5251:b0:4a1:f8cb:7d70 with SMTP id
 5b1f17b1804b1-4bb8881e837mr267264845e9.24.1795512886893; 
 Tue, 24 Nov 2026 01:34:46 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c50sm26488815f8f.37.2026.11.24.01.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 01:34:46 -0800 (PST)
Message-ID: <57582334-45ef-421c-a460-314f5b5ece74@baylibre.com>
Date: Tue, 24 Nov 2026 09:34:44 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 4/8] accel/rocket: take the core clocks and resets
 from the devicetree
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <82329b6681958350294846c830598ebde29b874a.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <82329b6681958350294846c830598ebde29b874a.1795478392.git.gahing@gahingwoo.com>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 00:01, Jiaxing Hu wrote:
> The RK3576 NPU core has six clocks and one reset, the RK3588 core four
> clocks and two resets. Take all clocks and resets the core node lists
> instead of naming and counting them per SoC; the binding defines them
> and dtbs_check enforces it. The driver only uses them all together.
> 
> On the RK3588 the resets are now deasserted in devicetree order, srst_a
> then srst_h; before it was the reverse.
> 
> Suggested-by: Daniel Drake <ddrake@baylibre.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Daniel Drake <ddrake@baylibre.com>

