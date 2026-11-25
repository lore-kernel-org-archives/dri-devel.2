Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC87606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0C5G1FZL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C5110E3CE;
	Wed, 25 Nov 2026 02:32:13 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C38F10E3CE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:32:06 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-386c4d2e2ccso2188541eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795573926; x=1796178726; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZkakucMXa/GLA6c3NEIv0nalbNEBO6xsvd9bftKJ/G0=;
 b=0C5G1FZLCYVn4D9H/A6JAd522orTwjl4km96tR+gWYGUhNsDOHwdJ2eyyQzH3uMJ5D
 PNTQxHXYhofcXZdNwMWqd1mOlosHomckLsNwtlt5YOjn5yYk2bPOHjXoPO7YZPoPSJ0Y
 xUIE/4oq1YzWnA0MJYydC5xxRw93q7LGLYE+5hVg8LXMSdRvg9+53e1oKwjYjoQxzKCL
 +sM5esQmKJaYnh7Sj3xSKRUDvL2gYHxvVRbC1PmZGDY0vkXjetp4ve68iEsh3J+HxyfZ
 p/OdtcJZBKimq+ZU11xBK85Z+TdwDF3v+ID29n6nJwbaRVI7I3SbxyYI5lOdxhBTQUAL
 7o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795573926; x=1796178726;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZkakucMXa/GLA6c3NEIv0nalbNEBO6xsvd9bftKJ/G0=;
 b=JV2RJqn1dxggC16xdYlbnf6g3578eQr5GCzpatLB9qsWELpwKLdrdcfTpUhxTfdTky
 nPsGbn96shQqTWkcULiXMeSFTiMprXDGOdTHJOwxA+9CHEJvnHZjjGpWxcvl7RLujQcf
 v4iVPbhg9wSWcJ+Pek7QSGP5nTWWJ4ZrXnnhqu4iWIC0IW4um1+RxCWQvNaZX6LYDYhU
 LEJmecjVZ1P1vN5U9ilicmsQ5T8NGBntB++owbWxxjAbePPFz1UCHOdfBDNR0s7vFVAB
 R6Zxj887o6rm/FFU7k45trUWLIt6uiikcLUmDW3e6A+AgxPVnfeC6bwJZQgXyp7zsP7u
 OS+A==
X-Gm-Message-State: APuU4Z9ZbIgkEFPS6OTd9yd9rOvNbFTiOYCYt4jpD8koN/AG8HYAV5Xj
 yGD85f2bZRexZwWxB7WUl/KgtMAGkLc1ctgN6GCUabHfBcsruCONWfyr
X-Gm-Gg: AZFdTZfWHcFnDJG0OTTFm8HmjFrgCTUYsjODq794BsUTmLbIFORBlbcmvzT8erWPZVI
 YwAUB6uNo/6zXfFlwHXIE71qlmHFpvflPyA+LlwVcsPPrD6+aiZ6k0drWd3QJpwbUWNLgHjpkhR
 E+t/L+SIJxNkZzvHzZrSnLpO/Bx7Y4gaQ7JX3Woa6CuhS21mvh6A3TU0VjUDP+gQj1no+6VE4/3
 ItwSUcSwSxkyCaj5lGH7x3ifM2yiCYtRiOgKiPCMDeF9Ksrnxo2w7T4hTBkvv5glQrCIbGMEc+a
 d0GbSNNzQNnNkaccpVd9mYuX7E3OKymQU3ETwHDnxjlfRBGH3YBRSEQpv5/i3dQKQam3VH+tGdp
 P2RnDrbns2lTyt9Puw/iPwC+WIYP6jqM9lXn6lhhUnQEquJdH91SOgdIHHVGvsc4fzlXkHequ/3
 AeC5nzIG368ByG45lJUTWDTkDs7HJdoJJAxHfRqbkdRd9rVeJwoI+3zhNAhtGB9BWt7/H19NrMl
 14fhxkFbTRfnpZHpVEF7ZzzK9ltwyhyayeevStwUXcM/lhItLLTAH9aHjnxD3Fb5oZi78xFiCQk
 HopV877OFUbrIdsWVcNGFBreTx6yBFVeDt4qbmLH3PEPzKsN545tNZp3bKA1UK1QpHKysYo=
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id
 5a478bee46e88-386b801cd3bmr6055021eec.40.1795573925600; 
 Tue, 24 Nov 2026 18:32:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm50729285eec.12.2026.11.24.18.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:32:05 -0800 (PST)
Date: Tue, 24 Nov 2026 18:32:02 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 conor@kernel.org
Subject: Re: [PATCH v3 5/6] Input: add Jadard JD9365TX in-cell touchscreen
 driver
Message-ID: <awZIEjbpVfVNoc05@google.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 10:11:26AM +0800, Hefei wrote:
> Signed-off-by: Hefei <3066883572@qq.com>

Spare a few words (or maybe even a paragraph) for patch description.

Thanks.

-- 
Dmitry
