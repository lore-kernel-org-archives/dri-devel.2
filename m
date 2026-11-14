Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E70606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYItl27q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7E510E1F0;
	Sat, 14 Nov 2026 02:50:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0E610E1F0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67744417F3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B51C1F000C5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794624598;
 bh=UizdDx/yb95rK0tTi0afEM4sxMr92PJ3xZkPFHYq/Yw=;
 h=From:To:Subject:Date;
 b=QYItl27qLYx9MZa3CMDb7CDYhEEmTZisxkIrGAtQYs0OG7X5N4taFuBvDycpZ8lg8
 BVMIjCpC9uWgjP0GqbxB1v63YgaVnQIRMbc1iPVoWVd779tBGob9UqLslYe3TTVikf
 4sX2pkqprbmofxbdRCQS1l4oAk2px/Rmn/WuW7AeEc9um01Piwfy4c75C0AkyODmXD
 W32MOu9u6rRqvdCiHafzX6NdldT7a12sG2fb6DHem15LolspA0CVA2/hpNzi55iNa7
 3AgrvxPvzikInoOGxJ+PB1FP9oluHFUwX22HJX+PFP61EI58YK+kHrF9cDx9N3+rmq
 g41/fdbXoRbvg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 43552C41612; Sat, 14 Nov 2026 02:49:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222265] New: amdgpu: RX 7600 defaults to limited RGB range
 (washed-out blacks) over HDMI since kernel 7.3.4
Date: Sat, 14 Nov 2026 02:49:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mister.freeman@laposte.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-222265-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugzilla.kernel.org/show_bug.cgi?id=3D222265

            Bug ID: 222265
           Summary: amdgpu: RX 7600 defaults to limited RGB range
                    (washed-out blacks) over HDMI since kernel 7.3.4
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.3
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: mister.freeman@laposte.net
        Regression: Yes

Created attachment 311464
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311464&action=3Dedit
Attaching the original unmodified 256-byte EDID binary (`original_edid.bin`)
from the Iiyama ProLite X2483/X2481 monitor

Starting with Linux kernel 7.3.4, my AMD Radeon RX 7600 outputs washed-out
blacks (greyish blacks, indicative of limited RGB range 16-235 or incorrect
color format negotiation) over HDMI (`HDMI-A-1`) immediately at early KMS b=
oot,
prior to any display manager or Wayland compositor loading.

Hardware & Software Environment
- **Distribution:** Arch Linux (up to date)
- **Kernel version:** 7.3.4 (Regression; previous kernels / LTS work proper=
ly)
- **GPU:** AMD Radeon RX 7600 (RDNA 3 / Navi 33)
- **Connection:** HDMI (`HDMI-A-1`)
- **Monitor:** Iiyama ProLite X2483/X2481 (1920x1080 @ 60Hz, EDID 1.3 with
CTA-861 extension block)
- **Desktop Environment:** KDE Plasma (Wayland) / Plasma Login Manager

### Steps to Reproduce
1. Boot Linux kernel 7.3.4 with `amdgpu` enabled (early KMS).
2. Observe the TTY console and login screen on the HDMI monitor before any =
user
session overrides DRM properties.

### Actual Results
Black levels appear washed out (dark grey) right from kernel mode-setting
initialization at boot.

### Expected Results
The `amdgpu` driver should negotiate and output Full RGB range (0-255) by
default on a standard PC monitor over HDMI, producing true deep blacks from
early boot.

### Workarounds & Diagnostic Findings
1. **Desktop Compositor Override:** Manually changing the "RGB Range" prope=
rty
from "Automatic" to "Full" inside KDE Plasma Display Settings immediately f=
ixes
the blacks once the desktop session starts. This confirms the default autom=
atic
negotiation in `amdgpu` 7.3.x is selecting Limited RGB (16-235) instead of =
Full
RGB (0-255).
2. **EDID Override (CTA-861 removal):** Stripping the CTA-861 extension blo=
ck
from the monitor's EDID (reducing it to a 128-byte Base EDID block without
CEA/HDMI extensions) and loading it via `drm.edid_firmware=3Dedid/custom.bi=
n`
forces `amdgpu` to treat the display as a DVI/PC monitor and restores Full =
RGB
range (true blacks) immediately at boot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
