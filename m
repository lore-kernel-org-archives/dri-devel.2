Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E1C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9AC10EAC7;
	Tue, 21 Jul 2026 17:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m6Js3W+4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D172C10EAC7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BAF7643862;
 Tue, 21 Jul 2026 17:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467BA1F000E9;
 Tue, 21 Jul 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653251;
 bh=f5RhMaiynjAvAswxGqKq77iW9AMfWLHK1GP6dW7cAOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m6Js3W+4iesf/d6+1Xd+umyZUNTNmLs0bVPFRgpcll9vbyvfuBSYnPw0yIN00MoS5
 i8KoQ5UuSTYkK3Kc5/zo39hIA6j11qMeY3Q6T9EgslfunX6debFtuYFLu8mm89mRHw
 sr/F174aA8BO0ZKLiDoRFBJSMGgINCHKPrtszFNbHC7myrVCPJFUsZKVu9CMy3YdE3
 hnpYTdDa5hdxttujuGahyk1EHWhbLWQQeKSa2OzBrWFldvW9b97FMBaynENK81skdj
 DHQOzrzT8U5lNxOBVU7PDDWqGLn9m+uXrCxw3dAdkI1zpBTiS7k6RJ0OCY+9OV/OkT
 Ht6O5AR/2TMCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] rust: io: register: make register have a typed base
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-5-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-5-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:00:50 +0000
Message-Id: <20260721170051.467BA1F000E9@smtp.kernel.org>
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

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D5

