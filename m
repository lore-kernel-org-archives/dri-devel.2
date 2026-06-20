Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70108CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 07:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA4910E194;
	Sat, 20 Jun 2026 07:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lEuLetpw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A3B10E194
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:47:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 342EC43BC5
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18DC4C2BCF6
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781941667;
 bh=x/UN75lDCxl9lHJjGsIPEKHYkhyvNus7rIX5x40+dqc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=lEuLetpw2j8EWtfUBHdhAcGqC0XTsUWBiyj0Z3FqQZlj84LQaOS91IlEVT/sfxIFX
 U7eSQgp74Ww1odWNr/4hpmJmU+mZYcr8fotdTS5CjvJZtH6vbeqYIVC2IPhjRp9cWE
 hFGf+v3XFW8yV2qN/aNFOOiyaks1k4zwJTk6AKZH17cOSjMkH4KrrZMrXTJiyvtXB2
 hwdTyNhvhV/+nDAD5eQi0zzg8eeCc2AiCm3heQsfq21+OTXQCqLMiiWyB49IBpnj9x
 ie3jt3DEBfov1lTL+Uf2Gk1Do1YoKt7MnRM/CUKNf/E/+K6eSyD9lU4hYEORymodmL
 LIRM5mjWhxD/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 11F78C41613; Sat, 20 Jun 2026 07:47:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 60533] CVE-2013-7445: Remote web page triggerable DoS in Linux
 DRM graphics
Date: Sat, 20 Jun 2026 07:47:46 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: dri-devel@lists.freedesktop.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version short_desc
Message-ID: <bug-60533-2300-k3sisl7aDk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60533-2300@https.bugzilla.kernel.org/>
References: <bug-60533-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60533

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|3.10/3.14                   |
            Summary|CVE-2013-7445: Remote web   |CVE-2013-7445: Remote web
                   |page triggerable DOS in     |page triggerable DoS in
                   |Linux DRM graphics.         |Linux DRM graphics

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
