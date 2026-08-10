Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C99C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2D510E8AD;
	Mon, 10 Aug 2026 14:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C1E8DfzV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F2510E8AD
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:25:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C356160254
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ADA8C2BCF4
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786371937;
 bh=WxabGio6tZH5p3RgYjBVTuwx+db08oGwAzjsFjD/wnk=;
 h=From:To:Subject:Date:From;
 b=C1E8DfzVw/Bd/fQPb5OmVOlgb73dRqul2rW0Fl5jndmt9vZ6DUSpK/vdnHMUamokZ
 IuVx33ISb2gyG+gNxA9259exgJcER8nb+JANXHBIBIw5czKCGQaXJGEcbpsomSYgyk
 K8d1cbm8KeTM/v9ffRQd/OyFe6xLK1CToY4Pu6NsctlqvbmlgV8IngfTCAnRdMDAEI
 zTeZ5ObeTjNka6tOzpnNcgkaIlruUkXB4KVJsK/xpQwTA8QoZqxYv/QokLNSFWQwPH
 j0sy2q+AjtcYH66YWZmcT3AycFYBxxzQBTmkM+cJ6AEgwdZ0GqUDseBp6NKeAzG4rG
 L0V2MzhwowQPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 58E54C53BC5; Mon, 10 Aug 2026 14:25:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221865] New: amdgpu: brightness 100% blacks out screen
Date: Mon, 10 Aug 2026 14:25:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@metantesan.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221865-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221865

            Bug ID: 221865
           Summary: amdgpu: brightness 100% blacks out screen
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: me@metantesan.com
        Regression: No

Hardware:
- ASUS ROG laptop, AMD Phoenix1 APU (DCN 3.1.4), eDP panel BOE NE134WUM-N82
(EISA BOE0B4A)
- Kernel 7.1.6 (regression: 7.1.5 works fine)
Symptom: Setting backlight above ~98.4% makes the internal display go black.
Setting it back down recovers instantly.
Diagnosis via amdgpu_dm_brightness tracepoint (/sys/kernel/tracing):
requested=3D64200 converted=3D65302  (works)
requested=3D64300 converted=3D65535  (true max, works)
requested=3D64500 converted=3D65535  (true max, works)
requested=3D64540 converted=3D65768  (> 65535, BLACK)
requested=3D65535 converted=3D66702  (> 65535, BLACK)
Root cause: convert_custom_brightness() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:
*user_brightness =3D scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(lum *
brightness, 101));
The panel's ATIF QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS (from ASUS BIOS)
returns luminance data points >100 (~103). So lum * brightness / 101 exceeds
65535, and the result is passed as backlight_pwm_u16_16 (u16) to
dc_link_set_backlight_level(), truncating to ~232 =E2=86=92 black screen.
Regression: 7.1.6 changed amdgpu_dm_register_backlight_device() from
props.max_brightness =3D max - min / (max-min)*level/100 to max / max*level=
/100,
exposing the overflow zone to userspace. 7.1.5's 100% mapped below the over=
flow
threshold.
Suggested fix: clamp the converted level to max (this is what the hardware
accepts =E2=80=94 65535 is valid full brightness, the plateau at requested =
64300=E2=80=9364500
proves it):
static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_ca=
ps
*caps, uint32_t brightness)
{
    unsigned int min, max;

    if (!get_brightness_range(caps, &min, &max))
        return brightness;

    convert_custom_brightness(caps, min, max, &brightness);

    return min_t(u32, min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) *
brightness, max), max);
}

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
