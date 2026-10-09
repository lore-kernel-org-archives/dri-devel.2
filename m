Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15111CA6017
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6170F10E402;
	Fri,  9 Oct 2026 03:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhbfjxSN";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2526910E402
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:00:40 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5d7daf06158so1140562e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791514839; x=1792119639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8p/rQ3UH6zCn7qLdglPOcw+wjm5XRLP5ezDaCm/Zd40=;
 b=hhbfjxSNTK/HtkR+lYjrF4jGvn9MDIZxGqsVRmahCAebfFVn3pkNw+TUbXhLDBTeYG
 KSKdmg4tCgyvEUjfIAHb9E59I7J4UIAubiDNd9uxHsR6lkpx+H0B3qfVLQ+i4fJ2CWQo
 fEyD/Y2Sr4L/P9idrbHJkj2jzhS9yWzfZAtw3v1T93p24a2TIyH8W19GxuyDs5BxGCaw
 ynYbhOgZLox52kOrVqde/IWzRAq+8yzNrkE0BrDmBWUMzKmj2N0OzXJDojw82p66Y63e
 fgXd7TFkdsZG2mpdLoGWGG/XPGSKAYgAaJlR81nodH1L4jQt0ZPfGimA04mYX/ywno0s
 ohLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791514839; x=1792119639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8p/rQ3UH6zCn7qLdglPOcw+wjm5XRLP5ezDaCm/Zd40=;
 b=yjh8E/9boQ5/CHWklp3XVVirZONXsYxAVu8vXnihiv7aEq4Zg4YK/+HNqyG7RDO1Dd
 nHMPCWlCSD3jCTyhuxuCJ89eII4XI18yZjiTirKu5Fjjxq/xFzGuenpMJdblIjU3qZ7M
 EPLivWPnbWgvxn/BShaGtu14grmJlFWw/HaUFNtHd8FMF4GVVFcTZS5GZ5UoqdjSTjj7
 EIH9CahrIIDRj9n/BxIEFAqJzTh4nzb2fW5oPQPDFcsg7T5COZYvtf9zJWJHVgnQT6rd
 fRBC8Ua8ZO2fd5X5CN2QdiOIYjskV0vBEn5SJf2ifjxUEJAX58GUa/vJl/FY9XZcq2NM
 yobQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/tPDT5NjxwzRCf7x1P5FhG+At42OZZxYtSLYWQDLKccYow9qXK4bQUJOeRrZ5HZMpIpbAIe0yeAY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiA/s7oUsVnlTn0kFS954YKeAFy0q1J7SMAYE4b7m+k+/+iX6X
 crcNXlnkgqUOZqQKBy63T5N8keNwG4bLELieu/Ite4bRcC8Df1QJ2eflK/54w8aeOxD30Q==
X-Gm-Gg: AYBFou3zwQHA+lZjyUAsXZZP82LKc1oGBfFumLCO3tiRn5kyopvVkGu/xNyBTPRY5uF
 ufMJaksL0oB6KI1vmrHesX3Fw+hagmuO0FmbSURtpTZnTGIfRnk6C3Wy+BqfINtbSbwUugTMKzM
 U+42gOYJELzwIvWcHq9U1iSjwfR3n6uXR34a2e7t7hUI54066h8rzPEKgG5yFMS6jDSKtJbjkxc
 3K7DfIJfCbd7FINOb+kLKlk+qixtnZCaccS7Nlc5LwtU2Kb1cIHnF88+T8mm0K2LtFcJEOjlkdJ
 pyVdFVQnk+T+1GRlQjOwdyTROHjrirRjYrt8fcP5V5cEW+MNLTL+qoXRK9uBsieDxmQOalKSTP0
 aQNWbd/UIdKpcmOXTaRpTjrCwHlXq79olsT5taDObvHzcK91VGCnV/jH0cmkUysa8luplqHdHpI
 4xAsW/VCeLzgDpHrf2/hMSD6fnEW3tw7LfkfJ/5j1sZWCm2g1KUHgKVwr6YGyUiVY=
X-Received: by 2002:a05:6102:5344:b0:7b5:1ca4:9df1 with SMTP id
 ada2fe7eead31-7cb365906c8mr241387137.5.1791514838797; 
 Thu, 08 Oct 2026 20:00:38 -0700 (PDT)
Received: from beelink.. ([187.13.210.57]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91cb29ca1sm757506e0c.8.2026.10.08.20.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 20:00:38 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/qxl: fix multiple missing bounds checks in
 execbuffer relocations
Date: Fri,  9 Oct 2026 00:00:27 -0300
Message-ID: <20261009030029.3040494-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913222956.2050281-1-qwe.aldo@gmail.com>
References: <20260913222956.2050281-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
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

Hi Dave, Gerd,

Friendly ping on this v2 series (4 patches), sent September 13.
It fixes missing bounds checks in the execbuffer relocation path:
dst_offset validation, oversized commands, cross-page kmap writes,
and src_offset truncation.  The v2 addresses the gaps found by
Sashiko AI review on v1.

Let me know if any of them need changes.

Thanks,
Aldo
