Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A5CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5480510F5A5;
	Tue, 13 Oct 2026 07:53:17 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED44710E4F6
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:43:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa27963eso1783845a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834234; cv=none;
 d=google.com; s=arc-20260327;
 b=Z8vm25dXE/BOaykhqxUVEf5IUKSwrrC7uTJFdrW2XEyQ20g40k+otimiEraIOtEhtJ
 cXA+HlZwiTeqP/qQf5Nkdr0ztd7iMgSfP2CtQ8bFGYF5kGd7p0lWLDxDN5BXMUPFQDjm
 BfiSpKGnYv2b/ZixQMOK36p6N7qbZ1w0K/DjNQwnG7QOQrmkSBeEVGU3WilwNIRMpcTh
 rrGwOmCEIhmXfaHQrgSMu+ebHn7LM/kr812KPuLcHXLZi6g3UB9LX79wEy37suof8uhw
 ZjwZ+YLGSRfxZwx9NmuoxIZHtbPSDIOW24G97/VNHEQcmw1BklnvRBzeg365XngHRcHc
 IZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=fKjrvAV+IumRAjQgNa7sO8gHIWvtGRpvC0rmKm5qiH4=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=PchYuN70MD7YcdGxvJSLNblgwbni1W7Ias6Bc68i8AEpPKBfMRy1qUR5pfzk+mRE4k
 6Tr5nceuFKC8xbuyfPlE+Y1zlMXtwwTfTdQjY7GKx/qQ5iUbLlRiHMZeN1NPBsQtTwq4
 /WU1/ES0nKjPkDm6FkESMJ+aEUCWQivYBrh88DpoER7y8KegNyT/CqjCbVb85tjUE/YG
 S72b9hUAG+lPoopsZB1VHvnDdj03luqcvD/U9nDgKnKG11eGnZLCjqLFeEkKU9q881i7
 SocwBnHWnH9reaBJtQb0PFi29zLrN+iZas2pBIRAKr80hsR6Xm1c20/HmmMVfQx++Wig
 WuKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791834234; x=1792439034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fKjrvAV+IumRAjQgNa7sO8gHIWvtGRpvC0rmKm5qiH4=;
 b=EVJUbzZJZdzq1Ce95uqHGMnTLRd4A4zmTR/dd+8h4Phi1z67tCNG8Crgo9FpyM5zn1
 Ss77pIVpJ4tnV2NMkH5MfijlYvztxNrYbEVEO7E5C7VynIsiFsRLDzk/fg75NO+1MU48
 LGp3Crm2bzfn9JS0jkOHditFUoVpXyoJJ3BX/TRHYMsnRcfuaMVQS0nM6do1a7eRZdDF
 UvbJm8/3U1TFNDy77ViuR+11PHk5s91jcmQVD1KKlCyORdONzC2czxkgiDtAl1PpA1Ub
 N9YQPjElSVIj2/4Rk9kWYBlch3VXM9cFdON+6Sy3ggK45rek7+bQUBdAKeXZSpUz3VHF
 249g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791834234; x=1792439034;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fKjrvAV+IumRAjQgNa7sO8gHIWvtGRpvC0rmKm5qiH4=;
 b=JeYYePq/RyXlq7YIkpzHS61TxqIxioKtgCph0WEe8szSTkMoQMokmCxII4I476AuSf
 gBUJqiFzx9SLhMuV8J1BkjjqgqzqNfopCPARWryHNHgtAqqjng4XbUrJFcuKKkHadXDd
 JPY0DYkpvzjVRgNOA3578beurjtkKuY/qpactoI1v6cRmdX2siKOk+M51yqPZD70p6zk
 8olroyKwh7Gi7H2GerfRRksiKduEw6l14CAOcOjG8uqzCuEC9Ymo+slsPheSeESUilQn
 KC6CcpTx+Hc9TDNUJQmXaOcDmmL42FPCWvtOHEGcj+lKblxJy+D3F1SBSKWbh2Go+a08
 jYtQ==
X-Gm-Message-State: AFq9FYJro8hAcfiVuZLbrMGCzWeM7TbpJtFvu6Wi/m/ANZPYOSsveQKe
 en2DTwZzlnhxpFUB4CLj+cykxFfg4LBqRnZByxTt3+mnxDuyux/DNkgvgUnx2xSo8k+BnSLrmIA
 8zyUFnRpBP4/kMN/+oEBHL3wJ2uCiHQRMB5w1DbyukQ==
X-Gm-Gg: AYBFou38giuLMdRsIUgzR4XwFT3N1zLbZ9quSkJDsP88N0TiSzjIF5mEa23htkRpnt3
 dNcHvlYO6vaSL/9iyQiELETM66cRm9kFm8iFKVS2TV9Ofz1eu9zqbMMuVYtxcjqxuhlhzTIPdX5
 KTNblu2OfcA/sMOmSl6Ruu36li4OOP35F1yqXhvOZqko+50Tuf6laF3IJ72EE7y8tEoZeLPgA3v
 G6wKcVed9zNYE3zlsNGxkXXYbG+ooSh9lt85S/1pzvRSx/MbSBrHJPrkLvpqSoky9TR2tz8V9mC
 ptv48wt9jX9ALD0QVO7HFUJmu15RrLm/UjCQI7XvnYjGwhPxIkljADfgFH7xvQb6rTU5ZXV7fSJ
 QGy09uv1Q7bg7VQDdjLlClQnqfyNGyQSuqTPxKzX0
X-Received: by 2002:a17:907:3d09:b0:c2b:ca98:872c with SMTP id
 a640c23a62f3a-c31a9fdff30mr1028550666b.20.1791834234155; Mon, 12 Oct 2026
 12:43:54 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Mon, 12 Oct 2026 22:43:17 +0300
X-Gm-Features: AclHuK82uFUZXzhoHslXmm7Kx-h3vnuOEW5fZXGAV4FFPbRfGlEKIB4ntDKq_4A
Message-ID: <CA+e2gLsfGRVzJ4WmGPOD-C9Bx8F=7Oeoc-v9FWUX-oUfNDRGCA@mail.gmail.com>
Subject: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
To: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

From: ukrainer8 <ukrainer8@users.noreply.github.com>
Subject: [PATCH] drm/radeon: retry UVD v1 init on failure after resume

On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
suspend intermittently fails the UVD ring test:

    radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCAFEDE=
AD)
    radeon 0000:01:00.0: failed initializing UVD (-22).

Cold boot always succeeds; resume succeeds only in about half of the cycles
(42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD stays
dead for the rest of the session and hardware video decode silently falls
back to CPU.

The resume path runs the same full asic startup as cold boot
(evergreen_resume() -> evergreen_startup()), so the difference is the
hardware state at entry, not a skipped call. The single 100 ms ring-test
window right after VCPU boot simply races the hardware coming out of
D3 + ASIC reset.

Retry the init sequence instead of giving up: on failure of clock setup,
VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
try again (up to 3 attempts). Each retry logs the failing step and the
attempt number, which also makes future reports of this failure mode
self-diagnosing.

On the same machine the patched driver went 6/6 OK, with the log showing
the ring test failing on attempts 1-2 and succeeding on attempt 3 =E2=80=94=
 i.e.
the retry caught exactly the failure the stock driver used to declare
fatal.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130
Tested-by: ukrainer8 <ukrainer8@users.noreply.github.com>   # Radeon
HD 5650M, kernel 7.0.0
Signed-off-by: ukrainer8 <ukrainer8@users.noreply.github.com>
---
 drivers/gpu/drm/radeon/uvd_v1_0.c | <diffstat>
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -158,24 +158,45 @@
 {
  struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX];
  uint32_t tmp;
- int r;
+ int r, retry;

- /* raise clocks while booting up the VCPU */
- if (rdev->family < CHIP_RV740)
- radeon_set_uvd_clocks(rdev, 10000, 10000);
- else
- radeon_set_uvd_clocks(rdev, 53300, 40000);
+ /* after resume the first ring test can race with the hardware; retry */
+ for (retry =3D 0; retry < 3; retry++) {
+ /* raise clocks while booting up the VCPU */
+ if (rdev->family < CHIP_RV740)
+ r =3D radeon_set_uvd_clocks(rdev, 10000, 10000);
+ else
+ r =3D radeon_set_uvd_clocks(rdev, 53300, 40000);
+ if (r)
+ drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attempt %d=
\n",
+ r, retry + 1);

- r =3D uvd_v1_0_start(rdev);
- if (r)
- goto done;
+ if (!r) {
+ r =3D uvd_v1_0_start(rdev);
+ if (r)
+ drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\n",
+ r, retry + 1);
+ }

- ring->ready =3D true;
- r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
- if (r) {
- ring->ready =3D false;
- goto done;
+ if (!r) {
+ ring->ready =3D true;
+ r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
+ if (r) {
+ ring->ready =3D false;
+ drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d\n",
+ r, retry + 1);
+ }
+ }
+
+ if (!r)
+ break;
+
+ uvd_v1_0_stop(rdev);
+ if (retry < 2)
+ mdelay(20);
  }
+ if (r)
+ goto done;

  r =3D radeon_ring_lock(rdev, ring, 10);
  if (r) {
