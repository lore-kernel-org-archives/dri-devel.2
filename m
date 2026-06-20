Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D9CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 07:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFA410E19C;
	Sat, 20 Jun 2026 07:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TrmR1um4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BFD10E19C
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:49:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A9E7043BC5
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A399C2BCFB
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781941796;
 bh=segOkhNBVblc+qq33uoDlJd2ApZ7aBDKrlPIHfDDTCA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=TrmR1um4KeQFBZbqMW7WLKZEMan1H9Y4A9+fftHa8g6i2oJ4OA5JFR3e1SwPMM0kP
 hy6B8waWNIEc1eBxWKqscrkgtQwh6DJlTAjpLR2v8UgPHnrf/qVbxf0wL+okrvPGYe
 HnD7ZMT8Ngo3MhSW4DvgDafVhMnLwX64z/x23prqfjC1Pj7rFSPiy3yvURalLozXs3
 EyhE5XJywXdsznhmiP2GzSbse0AoW9moejbLXqoI5XJjUM3YlNH771g827eIKykFR4
 QKOop9xcZjzFIT5Td8isX0iE7acjE9WnjQw7Jd0a35Y2eH3711o7Lyfhg5NAAv6ARq
 ZIXZ2r9+jLXOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 85D63C41613; Sat, 20 Jun 2026 07:49:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 60533] CVE-2013-7445: Remote web page triggerable DoS in Linux
 DRM graphics
Date: Sat, 20 Jun 2026 07:49:56 +0000
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
X-Bugzilla-Changed-Fields: bug_file_loc
Message-ID: <bug-60533-2300-Sskh9KrtWZ@https.bugzilla.kernel.org/>
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
                URL|                            |https://web.archive.org/web
                   |                            |/20130806203726/http://ec2-
                   |                            |54-229-117-209.eu-west-1.co
                   |                            |mpute.amazonaws.com/party.h
                   |                            |tml

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
