Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A046C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DAB10E033;
	Tue, 25 Aug 2026 11:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CI2w5PPl";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A86B10E192
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 11:25:28 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-92f0b5ed131so381546985a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 04:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657127; cv=none;
 d=google.com; s=arc-20260327;
 b=OeTBe4tbJ2IqCOGkKl8xUqJWCNN8UZ5hn/NUkqwd0NAztOgS1a9ccS1/ajRCqszmjK
 rvvdCQg92pE2Td9irAf/14M/xqzTeeOAOSi6KJBfkIrG2eyhSbapN6Mhy3gRTDMsWlSl
 mlWg2RJ0ihC3iJZ9t0xo2zeqn6/T8QhBuyWHsJr3Yq5kOtik8E/3gzZmy2g1BsgxNBQR
 ywsnThJkNwnIwGmzn9Fw3l/XaHQtjtDHDmCUqSoGfVxbUEBQFU+7cS/MDYgoOwB5VX1L
 /oddu9ZyxtcxUD1EXNY5AQTh7dNMKAEGnUwIEBGIF90Kenh0+hjX06EL6UNYgh9XVfx1
 Wpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 fh=juEw0coLp901Y3GWh66rH6zL1Jt+Ih4TNKLsfbXn8RE=;
 b=j8o+kW++2bQAVKisBLi/FcvIyNK9zUFEMMwMHpPKytDU/v8OnK4CIqgeOxR8tTEFr3
 ufRry85B+RfAnoWKp+gGbPEYUP86romcvfql2DjaGfs2r+owFyVhkQYGv95vo2GoG68m
 slu8bPYw63oT5kyu8Oz8m+Rj4ncjD+fZcAT+5wW+NyQgMwP82kocLOXovEMMIddKps86
 S6dzEhQkA91AKEbtdOUplMrd8K3NIlu35v0RI9V2TWPVvWgGHABruQFt8ULKOoOJx0dE
 uw7b1c9173BayWjmffs8NESh7qYf6EppM6zeqUKpU2ejYzCXiNPNESgJS6kYTGm34Zq6
 FbxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787657127; x=1788261927; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 b=CI2w5PPlAQh78VRcTssgo6Qh4WIGTHKOrfZrIP605tAe8e4La+W18MtLgV2NdNOalP
 kiUp27yWZaGIxg+0iY9nJU5xwHzmTKTTM/DCCzb0mHly18okCkb5OUWCvtsIsK3rTlEG
 FyJ3I8o9yjUbgryKGQVkf/q0lNnGaadbyLQvx4i6oZbYOuujOa0OoIjikwc9RNqlPZzi
 i+awccgkW4tVSipdsOjZhcUx7RHtxQloTS6974zpx3o94DdilcGcagbiYLgBtHn+oat+
 3fPgwwcsV21eE1M4/byEfcdWv+3VTTtglWbScwosXbIXp8m7rq1+lrBvGGbTUaqG2Xk5
 zjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787657127; x=1788261927;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bTk5vcYR8pi2e5/lQNvnOQAYENjfWWfdZ4lkpyYPlYA=;
 b=EOHee3zbKMqUOX7o1Ifa3NWtEdcsqJkpWHkzZo4uDsGgBa1AaiFUG6UBZhSgiUw+3C
 smtgUNvZFRV2u0hAjD5sSQcpbWWVqygj2t5NKIIJ/C11eBdQmBA9LiMnSxNp7R2qoCKr
 2LWpGvoRBVv8WKVhTKKWTSo/wBgQNWiLs7tpu9NFt5PLoj9U4vxCNJbXSVlwgco3l34b
 RREKBA1Y5Mo7ebr2SEytKzfE+YEo61kNYDLh204rWwM9t1bN6EwzPOEGEDZNh/4jHVZd
 1VynfgN9f2AdklDL9v9kGNj0h4nbK7GXeKVp7sc+1tKbP0UwZJo0LhxoETc4VbqVNEPp
 SlPw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpqp512rAC8zUk/Y3BFhe70NYrYDT2CZMvZdTGIjfGCBJ11evXw6WOb8llpLV0PBHfCdKxeSutHp1M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++miRRwpojf27Lw0B7PkWP9ZIQpYhZCr9E00Gnf/X7tS6TTxUbKp
 8MrWT7NhbhqXDU5HskQg6Vv313yJKFkhm9PQlv8cp2uCa1tEHYCiHAgTS2TuLgfFbFZhJO0c0A7
 n+60hCesXvQkxPtT1/NxvyCFU8xWUpjs=
X-Gm-Gg: AR+sD11FdU2vLBzMG5ebxosf15GBcs/p5Hicw0nK1pUAo6Z7W4SyPsWb/KqsNvXBWsT
 I4D+qytYcQUB/yI0v5J5/TnHkT5Jp9JesiiivR4f1lKyZdeAHtWdqN+vW/kg9b7L5PCMZsigqWT
 4LL1OxmhEmZanlpuepKyz71CSSvPIPYXuzRhxdgYcLtHJUMYI6C0o+HRJJvroJZ4J4vHl6o6S89
 gmqzuA/gPlBn3ZYRVbP9qIoSi72KdFrHHYL9bS0++Nu1rKYGBenPjFFkkdInOKyCa1pZNlguOPe
 8xEOefSOdeOQfJuv9B4MSJFMWHdMN2J7uOEyoM3LihfvbB7U6dAsscMccsJs+Q/KdEWAZrUgSDG
 rtgs=
X-Received: by 2002:a05:620a:3902:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-9374685c16dmr2214475185a.1.1787657127090; Tue, 25 Aug 2026
 04:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
 <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
 <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
In-Reply-To: <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Tue, 25 Aug 2026 13:25:15 +0200
X-Gm-Features: AcwNN1WgZlGvTNsBsAB_EDQkX72P-7AQnIjXxJ06yMCsNUZTXib0L-LoQc4rjh8
Message-ID: <CAFZQkGxwOQ6a+ZmjfNE=BnKV3VosOm6A_7=3rmWowTTwZsD3Tw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, 
 airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 daniels@collabora.com, harry.wentland@amd.com, leandro.ribeiro@collabora.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com, tzimmermann@suse.de, Alex Hung <alex.hung@amd.com>, 
 Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com, 
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

> I suspect KDE is not interpreting correctly the blend mode
Yeah, KWin made the assumption that pre-multiplied is always
supported, since the documentation said so in the past.
Thanks for notifying me, I'll have that fixed in the next bugfix update.

> I think we can keep it working as before by adding PREMULTI. In the end there is no overlay plane for DCE, and PIXEL_NONE and PREMULTI are equivalent when one primary is composed on top of a black background.
Makes sense to me.

- Xaver
