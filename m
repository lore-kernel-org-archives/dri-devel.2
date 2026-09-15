Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AB3C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A2D10F44D;
	Tue, 15 Sep 2026 11:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZyJu22BU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A3C10F44D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A243943B4D;
 Tue, 15 Sep 2026 11:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D521F000FF;
 Tue, 15 Sep 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789473303;
 bh=D7g9xDZ0omvORxToAZd7wz5+AlCcHiBcOzmxibNhlVA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZyJu22BUp/krcHqRNTq7jKcZ/omh/8BK0J0GGcmbyy5eXF7HLUhGysm81swJVRcRo
 fJATPHtnqwBnOk6PWVqaIPLWcfH7MWcD4yqz6G7e3EGCMvuO13BOVBnpv9ez1pkoHo
 h5dypooXJxYBa1oPbCPR5mUV6AbHtDqPpwLdNjZnOwcsbqEhQDByZ9Y6IWPAHL+aCB
 IGdiRVZ8zo4AG0M9gKDQBs0eP2aITK9r+bHOxAfCyl+sA6VP5e3n+m73i2wu6dE27u
 SdD2cWl466lslpt4/j2EFsvQA0Pnw2GlUhysF9C6CVND6+HZdKJG2WejdsdT6gvwdV
 rDjhEE9s7krJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 15/50] sh: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: linux-gpio@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>,
 linux-hexagon@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 bpf@vger.kernel.org, linux-mips@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-csky@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev,
 kexec@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Michael
 S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-15-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-15-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:55:00 +0000
Message-Id: <20260915115500.C1D521F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work mask. syscall_exit rereads the
> flags after the system call and goes to syscall_exit_work for any bit
> in the all-work mask, but hands over a copy shifted right by eight
> when the bit was in the upper byte. Reload the flags there and test
> the full mask, so that the bit reaches do_syscall_trace_leave().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D15

