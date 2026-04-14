Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A22F45A1C
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 05:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B6F10E065;
	Tue, 14 Apr 2026 05:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HwkuS8u7";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F18310E065
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:50:30 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8d68f702851so815457085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776145829; x=1776750629; darn=lists.freedesktop.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EO6dYTjceUlFmPDZvwvnjlhudlIzL5CQnQmzqEBRskM=;
 b=HwkuS8u7/hcoqKeQ1xQNr86Yf0IUqJV9e53Rrolu8ab89WL12UOUDmqdi3/ZK7fTJL
 Iugt9KyUJTkVOcejuCqEpnP1LaDvO10mSvvkq9V9C+LmwnTK6M6I9T66i+ebKNqjT1cm
 KBxk8BeUNC3aY5JIexn+UBRkhOa2uEGEFdrLAo081Hr52NG8brUjG5R7uovohT4c0KpY
 SD3rMWgSWrMw+VPe8J9818ys8Bkw9NKhW/qsShdhPsQWZRJoBV7P9/Gu5v1613iD6AH5
 hTqq3s+obwF+l9vGgIa+04QKhE2+Pv1uZ1QQcAvnauYNC7dBGKx/Jr18zXk1wWYQegcn
 Tylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776145829; x=1776750629;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EO6dYTjceUlFmPDZvwvnjlhudlIzL5CQnQmzqEBRskM=;
 b=fsUJVGCRDq63GJA710bdEwKDpAjZ5wCGU6wkgmGYYNH4J1nz5VD99C783qGsqDl4FP
 +ZcFp1FMz0WgGBKJBC9XTvygsoC9e6FBWJsPPNDWoavJE0G+isuZ3qCRU0YqJ/HbnD27
 Ioe5ydB0+ToTzc8l4n6uOvu5Kgsnss/LpnphLbYCd9BBD3ir9P+mYd28ftKzIyPMEome
 6dvX+A1jNAc1OiNStAwH3AtXKpjDHt05Mw0LQG/MTtXlllx1IQ+xd1HTPgWqxxGXAwNC
 uJcIkd8LwVkUzQMjGoQfoKe/0BVtH3DjIztOZd8m9qouQJN0MrU4EBV5gvK7N4fc8xbF
 2/Fg==
X-Gm-Message-State: AOJu0YyyG0XjFvN9jxV6d3XrUS7Z6y2WvhuMT0wsZmz/4IlKZlUH6xH0
 Jn7h5/P232yVreVAwqUIdMpaNZSo+O9rqX5Klqn1xA/s0FI0fPTARonh
X-Gm-Gg: AeBDietrwaL6XZBs/8eL7F009yR9eEj78EEqlDgGR0LaMPZxuT7bOAlLMPiCp17dJKf
 mYO480kHkysvX3Wu1AieTQmIsDZ/Ar60ANBFHha0tJRpFE9Q5vuUSrzj1+SPDdTuW1vkktJbnsr
 MOPxUvUEhhDzeyoz1vCXkMtN+9gWE0KeHjsfxQ0+EPR1+2ojFLNH17CYqBIm+LNZv7ASYNnWiWd
 taqw0t9DKX8mMcn72NUlcO2uG94bU86BVjJo4anT1qqkU4MzXMxUFy6bRNqCT1Jublfswof9xwb
 uDUVwUuIjl/We0VicYtBeLqWmTO+rMRPkcbTa31fc2Xk3UUKVJDgjXG/DDfgbHag0rvsD8DBMoa
 7iSUqYd2GjBSEc16j2Rr6v3svu+Lo11lNYa5LtIAk8Ji495WqDYKVoCxr4KPD7S9udehdR2sVUm
 2OVqeQKqVZX4CBTO2iF9kWnjeag8L/8itIUlZU7y+JcpcerpTqcOtZWIkcBcxSoaOypR1q7/I=
X-Received: by 2002:a05:620a:2905:b0:8cd:9bf2:60e8 with SMTP id
 af79cd13be357-8ddd0591fa8mr2511603985a.59.1776145828730; 
 Mon, 13 Apr 2026 22:50:28 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb934dcd3sm1067773285a.34.2026.04.13.22.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 22:50:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
Date: Tue, 14 Apr 2026 05:50:27 -0000
Message-ID: <177614582755.3604322.4429889371712210858@gmail.com>
In-Reply-To: <616c212a-067d-485c-802c-c1375094c53e@igalia.com>
References: <616c212a-067d-485c-802c-c1375094c53e@igalia.com>
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

SGkgTWHDrXJhLAoKT24gNC8xMy8yNiAxMzo1OCwgTWHDrXJhIENhbmFsIHdyb3RlOgo+IFRoZSBw
cm9ibGVtIEkgc2VlIGlzIG1haW50YWluYWJpbGl0eS4gV2Ugd2lsbCBuZWVkIHRvIGtlZXAgdXBk
YXRpbmcgdGhpcwo+IG1hY3JvIGFzIHRoZSBudW1iZXIgb2YgZXh0ZW5zaW9ucyBpbmNyZWFzZS4g
U28gZmFyLCBhbGwgdGhlIGV4dGVuc2lvbnMKPiB3ZSBoYXZlIGNhbiBvbmx5IGJlIGFkZGVkIG9u
Y2UsIHNvIHdlIGNhbiBndWFyYW50ZWUgdGhhdCBwZXItZXh0ZW5zaW9uLgo+Cj4gSSdkIHByZWZl
ciB0byBjaGVjayB0aGUgbXVsdGlzeW5jIGV4dGVuc2lvbiBhbmQgbWFrZSBzdXJlIHRoYXQgYSBz
aW5nbGUKPiBvbmUgbm9uLWVtcHR5IGlzIGFkZGVkLgoKVGhhdCBpcyBhIGdyZWF0IHBvaW50IC0g
SSBoYWQgbm90IGNvbnNpZGVyZWQgdGhlIG1haW50YWluYWJpbGl0eSBhbmdsZS4KQWdyZWVkLCB0
aGUgcGVyLWV4dGVuc2lvbiBndWFyYW50ZWUgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIGVuZm9yY2Ug
dGhpcy4KCkkgaGF2ZSBzZW50IHYzIHdpdGggdGhlIGVtcHR5LW11bHRpc3luYyBjaGVjayBpbgp2
M2RfZ2V0X211bHRpc3luY19zdWJtaXRfZGVwcygpIGFzIHlvdSBzdWdnZXN0ZWQuCgpUaGFua3Mg
Zm9yIHRoZSBndWlkYW5jZS4KCkJlc3QgcmVnYXJkcywKQXNodXRvc2g=
