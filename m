Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E26DC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7462B10F482;
	Tue, 15 Sep 2026 12:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XPGWfVIh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FEF10F482
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:15:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5277602C4;
 Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1B1F00893;
 Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789474499;
 bh=QRMZ7mmRdl98Hr0Jzx0dLUsIBC2R/cA4CuoG4//bR+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XPGWfVIhJ/wSL6Jd1KV8QYkaPXQevpxTo5YKyPKDIrxlw9MIHMHo5cZnoqRuYBPzW
 YAB/BBxKyr04OnAz1fXuFsMiapL3vJK/RuyN3woNJu65a7GotPewX23h9YHqDCxQPk
 2CWF6CYq7PbvZJuYpGBlpn9YbalxW+tFPh2E8PMbxAki0JSstQ2YNM5+QlpENVA4OR
 4S8OeAn9BG92ITePDtvvACim8Vy9KB2TGUTfda+kW7PhqaNdVyqOBZvhFMBFu6IU+R
 cXVP4LUVIrc7LmnOQ3vKo+sFLx/fVgoMs3/93rCsxZ1sqN6D06XnUMiUCyDHo1Jf2m
 gcjyzu+b66/Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 37/50] tpm: vtpm_proxy: install the server
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Peter
 Zijlstra" <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org,
 linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "David Airlie" <airlied@redhat.com>,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mips@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-gpio@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-parisc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-37-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:57 +0000
Message-Id: <20260915121457.BBD1B1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D37

