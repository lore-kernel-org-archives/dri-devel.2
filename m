Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F4C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13D410EFB2;
	Thu, 30 Jul 2026 20:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ9rcw+s";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740DE10EFB2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:11:46 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848593533cbso218829b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785442306; x=1786047106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
 b=WQ9rcw+s6LR2KBoFLTpwZMsVAcqSj+TfQC0nmqMl1PDOYlKdk2sIiE3tniz2NgpzbU
 J3RPiMy7BbV241olbh7YK9ruqsJAfJTahy/xnJhg1KQXhXhvbqAq8Rs6tQqyoGRPRUEa
 bjCDZbesWWuocWnt8xEmaIGNO8srA1qWZ3gwa2hdeeISuCX+V4NTGc1bTdYIrxSiMpvk
 Z6qDvBx923th5Vwhr8A/I61ZK6Jn5fksFAA+QNzmGLEZp/jgx3dvx0u+hxWLBvQ/rcPD
 /1y5V41CkfoG/dUdPWdTbLDJltqt0YNlehwh90H+6Z6xGI41vErCaiTTMcfbTK4PkkaH
 aY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785442306; x=1786047106;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
 b=FxhXaBrlYEF+p/6B9s1bg7UqsWQa2KZWTyg2iVUQ+bDOKlRYuRiOFlLaD0arInUk6c
 lcv0TnTtR5pJVyWt1fVQIqHLSXdmttrSCqWnysOPdcOrr6BgbBtu+Gppy+5gWGm5dIHp
 b17fxpmWdt4hbtbFgDuDtTBu6uxrfVPf16DeE9BPu1AdIQyj6dCjMwhMlbDBb4mWRwJs
 JHQEhKoHLS2MKspMYXGn/fvY1AR6ZCNg9SUO0ZXnVY+SrOffqC0syK73Kxr0xKb3ic4j
 cPT5lspNIXCiLuBLVQbqlv9VA6Miuep+mUsQiVXipOX/CLV4nZD/KCotW6rsYpcg1W+R
 osBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+jddkScmjEg8G64BGOWxiMzo0mHLEbOpsZw5WG+mbZWMy/jjpqH4hrdoFzRx/AsbzMBCvTFevevQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrKa+cV8NGg83TBNXdDpxOtbPE5aWQ5zeIWXZkw79FWH7qNXP2
 c9xokegms9S405HMDBNlBeOyNx7UpChPbN4XLOa5DybiffXfTaIY9vaj
X-Gm-Gg: AR+sD11dyMrvjbBG5De6Ir5Zi1cawl1nM1vebG8ErqV/7kGrpDT3FvzZUygmtPUTXZh
 RKCOdHJsjyBNOe6QuwD1wGYWrql87NNLM6FYWOBkwAZZuKkHHQOt94+BfjMdvSrrCO/CIXOQ1r5
 FNSMADhi9Lw1b52KhdjyjcU3gGNmFXuGKYafEI5x17Jw32STIsLqEOrhRQWoP4MMLAGhdpTohae
 r8+qI3LWoGG2JGFZjkVGG2/9VltnE1uSz0bHRJpNDnLKds9henD2UaChIEETUDALESekAN6uTKK
 sMj0W05VuwjTTkrdG//LuW8GI8gMQGFXG73IyslgBE2mGZChmgEXeK2FAVrvWYtJuZy/8NP2m1Y
 BI/8aP8UXQdFADCWk6RSsiX80NMUbVg0fCZMJ22AO7ZwJY0qe4tfGUUA12DARFB6O1uG9Xzpcl+
 91Ccn2zvwWqDeYLB8U8gTMjCo2hzrWHRvWWcl5zuJQzWpXJLH6oL70nPwc3roDukXaNj2uJsEVm
 A/7juA5VMJ8pyKq11jBYHYH98v+ttfavVO47fnGrhE=
X-Received: by 2002:a05:6a00:1741:b0:848:5b1e:aec2 with SMTP id
 d2e1a72fcca58-84ebc3e39b5mr3714867b3a.54.1785442305476; 
 Thu, 30 Jul 2026 13:11:45 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net.
 [174.165.208.10]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@kernel.org, ssengar@linux.microsoft.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, sgarzare@redhat.com, horms@kernel.org
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-scsi@vger.kernel.org, virtualization@lists.linux.dev
Subject: [RESEND PATCH 5/6] scsi: storvsc: Remove support for storvsc protocol
 of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:22 -0700
Message-Id: <20260730201123.1767-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reply-To: mhklinux@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older storvsc protocols. Remove the support and associated
special case code. However, support for the protocol for Windows
Server 2012R2 and Win8.1 (protocol version 6.0) is *not* removed
because it is activiely used by HvLite in the paravisor for Azure VMs.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 53 +++++++-------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 571ea549152b..095fce47c5f1 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -47,9 +47,15 @@
  * V1 RC < 2008/1/31: 1.0
  * V1 RC > 2008/1/31:  2.0
  * Win7: 4.2
- * Win8: 5.1
- * Win8.1: 6.0
- * Win10: 6.2
+ * Win8/WS2012: 5.1
+ * Win8.1/WS2012R2: 6.0 (also for HvLite paravisor in Azure)
+ * Win10/WS2016: 6.2
+ *
+ * Protocol versions earlier than Win8.1 are no longer supported since
+ * Win8.1/WS2012R2 and earlier hosts are no longer supported by Linux.
+ * But protocol version 6.0 is retained since it is used by the HvLite
+ * paravisor in Azure. The #define's for the earlier versions remain
+ * for the historical record.
  */
 
 #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
@@ -218,7 +224,6 @@ struct vmscsi_request {
 static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		VMSTOR_PROTO_VERSION_WIN8,
 };
 
 
@@ -1601,13 +1606,12 @@ static int storvsc_sdev_configure(struct scsi_device *sdevice,
 	sdevice->no_write_same = 1;
 
 	/*
-	 * If the host is WIN8 or WIN8 R2, claim conformance to SPC-3
+	 * If the host is WIN8 R2, claim conformance to SPC-3
 	 * if the device is a MSFT virtual device.  If the host is
 	 * WIN10 or newer, allow write_same.
 	 */
 	if (!strncmp(sdevice->vendor, "Msft", 4)) {
 		switch (vmstor_proto_version) {
-		case VMSTOR_PROTO_VERSION_WIN8:
 		case VMSTOR_PROTO_VERSION_WIN8_1:
 			sdevice->scsi_level = SCSI_SPC_3;
 			break;
@@ -1703,28 +1707,6 @@ static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 	return SCSI_EH_RESET_TIMER;
 }
 
-static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
-{
-	bool allowed = true;
-	u8 scsi_op = scmnd->cmnd[0];
-
-	switch (scsi_op) {
-	/* the host does not handle WRITE_SAME, log accident usage */
-	case WRITE_SAME:
-	/*
-	 * smartd sends this command and the host does not handle
-	 * this. So, don't send it.
-	 */
-	case SET_WINDOW:
-		set_host_byte(scmnd, DID_ERROR);
-		allowed = false;
-		break;
-	default:
-		break;
-	}
-	return allowed;
-}
-
 static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 						struct scsi_cmnd *scmnd)
 {
@@ -1738,21 +1720,6 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 	u32 payload_sz;
 	u32 length;
 
-	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
-		/*
-		 * On legacy hosts filter unimplemented commands.
-		 * Future hosts are expected to correctly handle
-		 * unsupported commands. Furthermore, it is
-		 * possible that some of the currently
-		 * unsupported commands maybe supported in
-		 * future versions of the host.
-		 */
-		if (!storvsc_scsi_cmd_ok(scmnd)) {
-			scsi_done(scmnd);
-			return 0;
-		}
-	}
-
 	/* Setup the cmd request */
 	cmd_request->cmd = scmnd;
 
-- 
2.25.1

