Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3523606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=DMb4oLpJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1868010E86D;
	Sat, 14 Nov 2026 12:54:54 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B9F10E86D
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:54:47 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so1756511c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794660887; x=1795265687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kzZ572SYqNYS7AFbKEhSpyO0POmges/XmCJlcN/iV2Y=;
 b=DMb4oLpJxbk5tXIcEk8yF1eFbZV1jaTb/QzY9pzEcfuNtIEdjL8YIJ4POzFAbl+cb/
 EWkFUbTTiQAOY9rxhKsd6A7KkJ1f3dbbd4lT7peoh0gaRggJASZSwixt0FfHN5T8XTY3
 g9Dy8gu0zSFKsNJ28lqNrhLeGl3yONPYHgeJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794660887; x=1795265687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kzZ572SYqNYS7AFbKEhSpyO0POmges/XmCJlcN/iV2Y=;
 b=Y9dCLDtklQa8yinA8nM/0c/cG0+9tBwjXL1yxiY6Vbu1iLwa+erTtbQGyuPitwEPs/
 e/ol3aqcV/nlWalNTu9QDHg+3vfBfkhVk2ccuORQ4SyNFy13YCylfcmmi+oQlKrVIFM6
 YBeyzch8M4uykUALOc1KP8EuH9EnbbaelohHq0kLY1z4hlgIqo4dHqN4UG8aOEnaVcdB
 bhwHm/P414dE/bcuc42UOTlmIBXyD1t24i8kH6MWwJM7+/9PRSpWojAc05HjThTsHd21
 FMmvZa8Gxmc6XG3KQtyrNqRoSHfUjW3CShYxRz5UCzhtdwtocnDMGWPOfGj+PvIuiWji
 lG+A==
X-Forwarded-Encrypted: i=1;
 AL+hErGTPo1bpev1ZSJe4cbT8NKyuiVPeg8OKeFFKGWcUFIne8eTvT2Mdrnd4yIbtLuwB75l/A/bcslopdQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2wnNyojU44OsCsgdcLZbPBxOxjDnAP7EW3cC/2QrkaduGCpAm
 ci3mq4E55FA2V5EoGJEummMk9shFvZdBmln2fS+vmoYm6HsYCSxxsg6DC2+OzSkyvTw=
X-Gm-Gg: AYBFou2i4N5vM3xBtOTNE5U0elTuQ/uE19i78FH+SnDOe8XV62bUXsI/xhY701Mi4Xy
 j7u1z9lkf/JGeTgDWFml505nsbDvhKXJJlrd1/eppkbmFQ8xaQaNwcsqcHYz7xeu/UbbNfjzWUp
 Y67d0ynZdB9IqBr3ezXnbzgnNk3cgdR54m38zRdafBkDu6Rt0E4nbH4UOBQP0yhYX99T+ynRPse
 Y4RlsykSBD2B2CPxei1VSJs8Pq0NxVthA06AqKt2Z0i9MvZ7egm5JGYrrtm3B7iKqaOUSzLtRQ8
 14iZtmPPG9CJ+UUiA1I0cXWSX1yoYOX58BT1RB1cKGucQNL3s1rU34yHOXMf6vfJL5l5WQmj6Q+
 qNJNPHLI/jQCm0OJH8pK0DEUpE7GnqwNSsSOANPAEeXl+afzAtIkNopMchqyLj302ciZk0UTVba
 TriaUwcHGyr2iMfTzCiAcPSQvwOBdbtWUSdmBuw4hthwztphkEYMZZpmFhtg+jjOaR0RXIXcQCr
 QsXnvIrznWgul0dC8J8V34TV1AOTilgq63HaZdr+ORWzB9YGRNeYMhZtKOU00gKSwnj9+BmAuTV
 gABpmpOD13RMoUBKcBHT/4QPuLdktjDFfaKpNSKA5J9Fgjil0AA8N84WaHcDo96X4EVpGRWyAU7
 LhzpAA5YF3EB3
X-Received: by 2002:a05:701b:2706:b0:1b2:4c54:d976 with SMTP id
 a92af1059eb24-1b50311d3e0mr5111198c88.31.1794660886535; 
 Sat, 14 Nov 2026 04:54:46 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319e381sm15468097c88.12.2026.11.14.04.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 04:54:46 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, royalnet026@gmail.com,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 00/12] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 14 Nov 2026 21:54:35 +0900
Message-ID: <20261114125437.9986-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 04:05:17PM +1300, Jiaxing Hu wrote:
> This series adds RK3576 NPU (RKNN) support to the mainline DRM rocket
> driver.

I checked the accel/rocket patches for regressions on a ROCK 5B+
(RK3588): MobileNet inference with up to 6 concurrent clients, runtime
PM cycling, core unbind/rebind, GET_PARAM (returns 1) and recovery from
93 forced job timeouts all pass, with no warnings.

For patches 2-5 and 8-10:

Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, ROCK 5B+

Thanks,
Sidong
