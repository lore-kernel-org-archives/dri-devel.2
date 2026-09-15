Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00BC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767D610F3CE;
	Tue, 15 Sep 2026 12:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EFlkG4kl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A74910F3CE
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:12:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A19240523;
 Tue, 15 Sep 2026 12:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7195B1F000FF;
 Tue, 15 Sep 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474333;
 bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EFlkG4klTh9q0ksv7M1hSJKTTDQQe7H5iyO2zHATvBU+UXti67y8RU1/odOq/zhGR
 VYQ/UthUrZvWy+XndwZ77DKsyT/9Ri6pFxYRhTSWuJI+DH+4yLpyuhu8mAIrHMk8t/
 6kDv1q8AwhLZ6F1rb+P8f3KP0PwnSljmvJWSc46nWvAQt32cRvhQ+HBCxLIdV4HK1y
 DBbf6pk3x8FN6xy4faUytIL4oO+ojk8F8MkK5f1LgG4gC4ZmwrIhyHU1W79T6CKby7
 mQNMHJsClSUixl8DuKxj7EGI22mNfTcwiHmk42y9GBCpJ9M/rUqbu9RbXfhHzUFMg4
 vNY+QKqLhGlQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 38/50] perf: stop putting the event descriptor
 back on failure
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org,
 linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 "David Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, bpf@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:12:11 +0000
Message-Id: <20260915121211.7195B1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D38

