Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA3BC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EB510E2C4;
	Wed,  1 Jul 2026 01:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rcpassos.me header.i=@rcpassos.me header.b="cY5TEfE6";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="CWDlA1L9";
	dkim-atps=neutral
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA11E10E2C4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:22:11 +0000 (UTC)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=cY5TEfE6AXUENknDiPE5GUfaWMaCpae8IgWdtuUuKJAwyEN4L8f2kF3/UfGSymKniV0Ii7Zf83cHCivNBSlHnZEPCju6rjInu0NOaXKTA2mRMpgl/2xMOPdz4P9jSbzRRDc2/KxVmEKVrLmBf1qug7dO0/HG2MZ76T6XehUoPTjEztokDlf2F/nG4Gj9vbpzuSXawkleZ81I2518h3vf0MWHkZHpHE7/84f66kiR/2dhAS6Mzoqv2nRCJSGbfNdv/y6TNYGmEoRn42oNeNmGgQ/FST81IQQ0YB7WbEKAYDvG+pZf8B1XufpqDYuXOOiot9pfZM7/hd5lN/aDFZcGWA==;
 s=purelymail2; d=rcpassos.me; v=1;
 bh=b9Lc5ANznPsadDX0Lpk40jsOORthKNT3ENHScNXKTHE=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=CWDlA1L95vUATAxDjikT8ipA6OG17MGPpxv42xu3Kh+Ej4g/hG/5R4v8266n2O+Ia+SqIhZa/Gt1T+1lLTOB0PL9WiijEZDEBQmAd/UyagMWgXovq5IasKnJ1vHbVWYD9y0xIJ/Q2RdH9700BaN7K06xu+2QrgbTORB39m0362PWEJv3bHyi1VGJNpmRlhE6AO4fzBoDv+6cVkHFsCtl4lp0ft6cCE+4sfgszx1FGSk5vRNqajLubxap/jl2F83gt6Ew0IMSBHt1Iw8fAeQ3i/eku30IfZhq6RQZtWHicrTgD/wLWzTD/M/avkc2Qaa5PlY5P+yh9oxNvwMEbjsqHw==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=b9Lc5ANznPsadDX0Lpk40jsOORthKNT3ENHScNXKTHE=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: dri-devel@lists.freedesktop.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -604878159; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Jul 2026 01:21:25 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: Rafael Passos <rafael@rcpassos.me>, Randy Dunlap <rdunlap@infradead.org>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND v2] Documentation: xe_drm: fix chars used for subsection
Date: Tue, 30 Jun 2026 22:20:58 -0300
Message-ID: <20260701012141.167868-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

Fixes "ERROR: A level 2 section cannot be used here".
Equal signs are reserved for document titles.
This file docs gets imported by driver-uapi.rst,
and the page title is defined there.


Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
Hi, I send the v1 for this patch only for the linux-doc list.
The v2 fixes this, and has improvements to the commit message.

It was reviewed and tested by Randy Dunlap.
I decided to re-send since the original emails was not in picked by lore (n=
ot sure why).
https://lore.kernel.org/intel-xe/1a20e4bf-fd7f-453e-b7a8-c7feb0b077c6@infra=
dead.org/

In case it helps, here are the tags Randy added in my first send:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks,
Rafael Passos

 include/uapi/drm/xe_drm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 48e9f1fdb78d..4dfb30e6c8a8 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -2537,21 +2537,21 @@ struct drm_xe_exec_queue_set_property {
  * Refer to Documentation/netlink/specs/drm_ras.yaml for complete interfac=
e specification.
  *
  * Node Registration
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * -----------------
  *
  * The driver registers DRM RAS nodes for each error severity level.
  * enum drm_xe_ras_error_severity defines the node-id, while DRM_XE_RAS_ER=
ROR_SEVERITY_NAMES maps
  * node-id to node-name.
  *
  * Error Classification
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * --------------------
  *
  * Each node contains a list of error counters. Each error is identified b=
y a error-id and
  * an error-name. enum drm_xe_ras_error_component defines the error-id, wh=
ile
  * DRM_XE_RAS_ERROR_COMPONENT_NAMES maps error-id to error-name.
  *
  * User Interface
- * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * --------------
  *
  * To retrieve error values of a error counter, userspace applications sho=
uld
  * follow the below steps:
--=20
2.53.0

