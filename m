Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE2606A332
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=slax.org header.i=@slax.org header.a=rsa-sha256 header.s=google header.b=mua3JHWI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8571810F33C;
	Tue, 27 Oct 2026 09:32:18 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CD510E05F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 02:25:34 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3a75f960be3so32273391fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793067933; cv=none;
 d=google.com; s=arc-20260327;
 b=aR7WQ+ZGyuxtI0SEBYq1KWTp2eV6Ns1BInSdjaix410rYFcwotOro1CuWd4UpF1E7O
 GO3VTSfjcS700NQo+BCojACzKat0wSfWE3GvoXKadyV7uyS4UJBBKEhIiyd2J/AvmDR2
 2AndfLkPm74gOzoO0OqHIt1lHqjtc6q4nm4qZYPGUX8zqotZOPQTePILQkuceWraN7L3
 RPp/4FILfh6UqQJl8hRhFR8Uo6f3UhqtxIg/MB/mPT1Uj/Iynxl9EK0wAY9vQqnXGrup
 vbM616yB+P976TcyvgHpPqolPD8AjJm4DA5BAigA6SCc4+Bg+c/GUWtSnBm+is0cDUpJ
 qrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=YgY4OQeeCYS2rB2B7n046hbM3eMAPMynIOiWENkrKig=;
 fh=6zpupYmTXy6A1Xb8djqmje0ZuZInodkMBscBOat38B0=;
 b=S2sjRNBfqJ74B5S2fyhB/CvDj/1QbR8jyjQbENx8VSIMqznrcWVfAjY4MGiAkRhT40
 lkMRwKrRtF37PlLQtt8mBITXw0DgNuThfN6+6gDeXzvxhn8jdJBVwtbSQDpHHptsntAL
 6ukR11ec0xhVqiBl178Ak20/+w5C+IhEVxKGilflIXniNeBp7BNPGSpgbgTMxxzagvqe
 ZtcJOnnOhSr1B2DnhN1WiuJzoZ1dxBYrMFowTDUdO/sbW4KpCR+FtjS8CfTxZv2vOp/u
 Z7RMPsNSG7m7PuB8mjRQPcSi78tvk9CgXoqotHjgdM459oyoy+zTm4D5dVGLFwf50ODX
 7/2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=slax.org; s=google; t=1793067933; x=1793672733; darn=lists.freedesktop.org; 
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YgY4OQeeCYS2rB2B7n046hbM3eMAPMynIOiWENkrKig=;
 b=mua3JHWIFD2RqpD39i6OSGbSBGMADSUnn5Nb1bUmeXSeYrUw0L0xIxQ4BeMApix2G+
 DZm7t+eTATW8kgDQMY9cnQ4Z+9nx0b6p3xSo6Up6StIOxUFNxvc/XyhRf/P/njsgCw55
 Gaf7dJ44dw6EnjDUfOtOyIjrwmLxTbGQNhJtyjy+KWOw50lGV63Iw1c2dqymJH5HBtA4
 ct6NntWEOKiZJ40u/5l8l9GEwgYNuR2lsRJTuQyTk4prvs5IV19c0P6oSdN1+FpOHuy9
 YF8x5vv9CnF48TcEzxG0sLSlSOXRCUJ2u+s44j2oiHCcTbC+WU8LNQTeYLcziqhKHotp
 5N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793067933; x=1793672733;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YgY4OQeeCYS2rB2B7n046hbM3eMAPMynIOiWENkrKig=;
 b=eityfQ598qcl/nHP/5RztsZs5buvqfGCe4K09DI8SgXh6tw1iuilHQvNrP2bEPRrAF
 XKR1OIP+NTif+HGHxsr1O1NWL6GdvBvb8mkVoIH9ppdLXrcA4am3mCfmiTOXGlDEY103
 oCRgtO2lRhfrAj3tOh6mAT/c5JrILfZVw0i9BZmvceR7QCqX9PCD9MGkz7FO+6Y/aL0r
 xlnRIdG7qhKBseQU4DrjI4BMP7RfyZXDw+PCle2vqbtF7MiRGbF5rgOeKlcenWpw5550
 N/q1NGQ7MJ5qlErIBVJQir2/PkNRaAMoBlrLu5aGkQ9PrqIaYZuV94XPZMnOfH0GX0b1
 yk0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFAqhYgGH77uCVOgo0WhDFJSQfKdsQ/YymQ3ru5E4SvY58aXJSxX2C9xfLCYpQCe5U2ycISlvY9jk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJERHUVHQ+NRxv29E4B9Y9Ad+BDL+JnJmLYKIqItVB8iizem1rC
 euHDIcUYrgRDCQZsPTTnc+ODedTByXI/I3w3tNiNx0VETYuRVVT1TauOiR1HgM3PArLRNjCpH5i
 u11kx1wdfNoKsQcO2D5zANBnN71UVmZEx8QnQ6y0x9A==
X-Gm-Gg: AYBFou1aIrrchqnnmQ9vHfJcvODJav6ExpLg9JGmpuuacrjSXH3ZfJBHGJ9+5kKxwlb
 w0FCywu1Z9eNu3gDOnVBN/5RhUrAqFhTZhgi9oRcBNCr9TMYMrFlxM+W3NJKL3JO4BNl06fHvcK
 OWO4LdAu3t8KIe4WjuzKWDIGor2rJzIi58soNBM4Dn4uERfRQBBPg/9k2R/U3Fu13WtK6+A5+Uv
 U4RkYK0B1G3G1APgGgcCfMkNwMaZlnX1GcxoMLOOeRy9+/Fi61xelwo+4GK8Ewf3wqkCGwabSfd
 O4VJtq5N8DOWh6DM2Nmyy/nMubL0mDroafsH0j8aPaOkI9W+hD+zvf7fGucB1u95oZy79DTZ4P+
 21pGuOkaKEd4olclSNojT9AUyCGx02nUhZqx1ox8r1S535DywVPTgSSJ+mCzzuDKn65E=
X-Received: by 2002:a2e:a99f:0:b0:3a5:dfd3:41b9 with SMTP id
 38308e7fff4ca-3ac6fcff2e2mr21287791fa.14.1793067932516; Mon, 26 Oct 2026
 19:25:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAL1oBhpCSzXmPDRLeyJW443ocXyZizkFnzDLQz44BRPPTv0reg@mail.gmail.com>
In-Reply-To: <CAL1oBhpCSzXmPDRLeyJW443ocXyZizkFnzDLQz44BRPPTv0reg@mail.gmail.com>
From: Tomas M <tomas@slax.org>
Date: Tue, 27 Oct 2026 03:24:55 +0100
X-Gm-Features: AclHuK_fisuPv-N_6mgnIsTCfUXDsjNd6sK-D6Pg4klZAd2hAeo3dmdc-fcVIdQ
Message-ID: <CAL1oBhoT+F+On=d5m=Jofmee81kPsFv5mc8z1-rst1krCX71EA@mail.gmail.com>
Subject: Fwd: [BUG] drm/vmwgfx: GB_ONLY cursor updates ignore legacy Xorg
 hotspot
To: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000002d3333065ec92946"
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002d3333065ec92946
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a cursor hotspot regression in vmwgfx while testing Slax
with Linux 7.2.9.

Environment:
- VirtualBox 7.1.10, VMSVGA, 3D acceleration disabled
- Debian 13 userspace
- xserver-xorg-core 21.1.16
- xf86-video-vmware 13.4.0
- Hardware cursors enabled through normal driver autodetection

Resize cursors appear displaced from the pointer position. For
example, a horizontal resize cursor with hotspot (13, 6) is drawn
13 pixels to the right and 6 pixels below the expected position.

The theme file and XFixesGetCursorImage both report the correct
hotspot (13, 6), but VirtualBox's VMSVGA diagnostics report (0, 0).

Code inspection points to the GB_ONLY branch introduced by:

  eef295a85082 ("drm/vmwgfx: Restore Guest-Backed only cursor plane support")

In vmw_cursor_plane_atomic_update(), this branch passes only
vps->base.hotspot_x/y to vmw_send_define_cursor_cmd().

However, xf86-video-vmware supplies the hotspot through
DRM_VMW_CURSOR_BYPASS, which stores it in
vps->cursor.legacy.hotspot_x/y.

The position calculation adds both hotspot components, and the
LEGACY and MOB image paths also include both. Only the GB_ONLY
image path omits the legacy component.

The attached patch uses the same combined hotspot for the GB_ONLY
image and its position. It fixes the displacement in our VM.
Additional tests with custom cursors, bypassing the cursor theme
and window manager, confirmed that hotspots (13,6), (6,13), (9,9)
and (7,11) reach the virtual hardware correctly with the fix.

For completeness, this setup also encounters the separately
reported zero SVGA_REG_CURSOR_MAX_DIMENSION issue:

https://patchew.org/linux/20260830151619.2452307-1-yunfeng.li.nb@gmail.com/

To make hardware cursors visible for these tests, our kernel also
has a local workaround that retains a 64px limit specifically for
GB_ONLY when that register returns zero. MOB validation is unchanged.

Could you review the hotspot fix and consider applying it upstream?
I can provide further diagnostics if helpful.

Thanks,
Tomas M

--0000000000002d3333065ec92946
Content-Type: application/x-patch; name="vmwgfx-legacy-cursor-hotspot.patch"
Content-Disposition: attachment; 
	filename="vmwgfx-legacy-cursor-hotspot.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvq29g580>
X-Attachment-Id: f_mvq29g580

LS0tIGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfY3Vyc29yX3BsYW5lLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfY3Vyc29yX3BsYW5lLmMKQEAgLTgwMyw2ICs4
MDMsMTAgQEAKIAkJcmV0dXJuOwogCX0KIAorCS8qIEluY2x1ZGUgbGVnYWN5IFhvcmcgY3Vyc29y
LWJ5cGFzcyBvZmZzZXRzIGluIHRoZSBpbWFnZSBhbmQgcG9zaXRpb24uICovCisJaG90c3BvdF94
ID0gdnBzLT5jdXJzb3IubGVnYWN5LmhvdHNwb3RfeCArIG5ld19zdGF0ZS0+aG90c3BvdF94Owor
CWhvdHNwb3RfeSA9IHZwcy0+Y3Vyc29yLmxlZ2FjeS5ob3RzcG90X3kgKyBuZXdfc3RhdGUtPmhv
dHNwb3RfeTsKKwogCXN3aXRjaCAodnBzLT5jdXJzb3IudXBkYXRlX3R5cGUpIHsKIAljYXNlIFZN
V19DVVJTT1JfVVBEQVRFX0xFR0FDWToKIAkJdm13X2N1cnNvcl9wbGFuZV91cGRhdGVfbGVnYWN5
KGRldl9wcml2LCB2cHMpOwpAQCAtODE2LDggKzgyMCw3IEBACiAJCQl2bXdfc2VuZF9kZWZpbmVf
Y3Vyc29yX2NtZChkZXZfcHJpdiwgYm8tPm1hcC52aXJ0dWFsLAogCQkJCQkJICAgdnBzLT5iYXNl
LmNydGNfdywKIAkJCQkJCSAgIHZwcy0+YmFzZS5jcnRjX2gsCi0JCQkJCQkgICB2cHMtPmJhc2Uu
aG90c3BvdF94LAotCQkJCQkJICAgdnBzLT5iYXNlLmhvdHNwb3RfeSk7CisJCQkJCQkgICBob3Rz
cG90X3gsIGhvdHNwb3RfeSk7CiAJCWJyZWFrOwogCWNhc2UgVk1XX0NVUlNPUl9VUERBVEVfTk9O
RToKIAkJLyogZG8gbm90aGluZyAqLwpAQCAtODI5LDkgKzgzMiw2IEBACiAJICovCiAJY3Vyc29y
X3ggPSBuZXdfc3RhdGUtPmNydGNfeCArIGR1LT5zZXRfZ3VpX3g7CiAJY3Vyc29yX3kgPSBuZXdf
c3RhdGUtPmNydGNfeSArIGR1LT5zZXRfZ3VpX3k7Ci0KLQlob3RzcG90X3ggPSB2cHMtPmN1cnNv
ci5sZWdhY3kuaG90c3BvdF94ICsgbmV3X3N0YXRlLT5ob3RzcG90X3g7Ci0JaG90c3BvdF95ID0g
dnBzLT5jdXJzb3IubGVnYWN5LmhvdHNwb3RfeSArIG5ld19zdGF0ZS0+aG90c3BvdF95OwogCiAJ
dm13X2N1cnNvcl91cGRhdGVfcG9zaXRpb24oZGV2X3ByaXYsIHRydWUsIGN1cnNvcl94ICsgaG90
c3BvdF94LAogCQkJCSAgIGN1cnNvcl95ICsgaG90c3BvdF95KTsK
--0000000000002d3333065ec92946
Content-Type: application/x-patch; name="vmwgfx-legacy-cursor-limit.patch"
Content-Disposition: attachment; filename="vmwgfx-legacy-cursor-limit.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvq29g5o1>
X-Attachment-Id: f_mvq29g5o1

LS0tIGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfY3Vyc29yX3BsYW5lLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfY3Vyc29yX3BsYW5lLmMKQEAgLTc0OCw2ICs3
NDgsMTAgQEAKIAkJdTMyIGN1cnNvcl9tYXhfZGltID0KIAkJCXZtd19yZWFkKHZtdywgU1ZHQV9S
RUdfQ1VSU09SX01BWF9ESU1FTlNJT04pOwogCisJCS8qIE9sZGVyIGhvc3RzIGxhY2sgdGhlIE1P
QiBjdXJzb3IgbGltaXQgcmVnaXN0ZXI7IHJldGFpbiB0aGUgNjRweCBsaW1pdC4gKi8KKwkJaWYg
KCFjdXJzb3JfbWF4X2RpbSAmJiB1cGRhdGVfdHlwZSA9PSBWTVdfQ1VSU09SX1VQREFURV9HQl9P
TkxZKQorCQkJY3Vyc29yX21heF9kaW0gPSBWTVdfQ1VSU09SX1NOT09QX1dJRFRIOworCiAJCWlm
IChuZXdfc3RhdGUtPmNydGNfdyA+IGN1cnNvcl9tYXhfZGltIHx8CiAJCSAgICBuZXdfc3RhdGUt
PmNydGNfaCA+IGN1cnNvcl9tYXhfZGltKSB7CiAJCQlkcm1fd2Fybigmdm13LT5kcm0sCg==
--0000000000002d3333065ec92946--
