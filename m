Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB4CD37B2
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 15:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0156010E1C7;
	Mon, 11 May 2026 15:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BoIhIUOn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A42610E1C7
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:38:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F9D16001A;
 Mon, 11 May 2026 15:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0950C2BCB0;
 Mon, 11 May 2026 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778513909;
 bh=9ia61t/3shFk1R60vyvSaUERpQ90L5BXzWA6QW+wDtc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BoIhIUOnaIlW+MnzxR/uMWc16ngYvlR47JXvEOIojWCgv+yOsqkEnUBrTlv31Vp2d
 rDDG/1ax8xJqaWFPjyqfokqcrAJc+29kCVr50Ed8F/sxflOhNNnarm8nfpJV4l0x1T
 Y+vEnQY+hLuco2xJ/nODUHCa5BOsPzYm83l+pttcySsAH86raeKFCGk0zFW05pxJnY
 YEcznmxGerOMikP0VFpfqjNhmkp9gYUDF5zrK/Iwbj79Igo4lMGAsMzb+V51E5XyNZ
 o0EWjDiCjAQTPqvx1XovFVTJb+pv8T2Onz0fSn50edXo62GI3cV85B8fY+5gOGZ1YY
 gY5SGialON/xw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] rust: auxiliary: replace drvdata() with
 registration data
Date: Mon, 11 May 2026 17:36:17 +0200
Message-ID: <20260511153616.3241557-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152400.3905096-1-dakr@kernel.org>
References: <20260505152400.3905096-1-dakr@kernel.org>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue,  5 May 2026 17:23:06 +0200, Danilo Krummrich wrote:=0D
> [PATCH v2 0/3] rust: auxiliary: replace drvdata() with registration data=
=0D
=0D
Applied, thanks!=0D
=0D
  Branch: topic/dd-lifetimes=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/3] rust: alloc: add Box::zeroed()=0D
      commit: abb21500e7e5=0D
[2/3] rust: auxiliary: add registration data to auxiliary devices=0D
      commit: fd3b87ff0232=0D
[3/3] rust: driver core: remove drvdata() and driver_type=0D
      commit: 95ade775c4ab=0D
=0D
The patches are in the topic/dd-lifetimes topic branch and will be merged i=
nto=0D
the corresponding target branch soon.=0D
