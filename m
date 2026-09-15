Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF66C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F9210F47B;
	Tue, 15 Sep 2026 12:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RmyX0EJ1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619DF10F47C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:11:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC954602A8;
 Tue, 15 Sep 2026 12:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D341F00893;
 Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474285;
 bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RmyX0EJ1B0zOgT5ioEXRLk+o4F4Y5EudQ2MyBappoNbd4lClHN+PysLRe+lqvPVp5
 tBwJMbqCeZEv7naOUmB5POnQKn+dbX0K1SIPTGnovxWaK3d1hrbCQzt+QTOIjSS0jv
 ozOLD3b4lQSvA/CU30dXodluwPZzgV+Ca6K7iJVN6Vk+KD4JQXyjNYe7jK3mYcGLUH
 4XnCIyui6X4vRwCLNy4FaV+3AmDMv+qiX7nSh5emNDsXdPMr643qZCL0VouKa3ayzv
 pThUPgyUG/CP/C8WVCikSGDKsjSd8zkAPHVNK+58jF+szrJfKJpZ9+ygivmoI9WEAz
 pHHOzSGPpXmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 29/50] drm/virtio: install the out-fence
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org,
 "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jann
 Horn" <jannh@google.com>, linux-parisc@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
 io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:23 +0000
Message-Id: <20260915121123.B5D341F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D29

