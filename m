Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FF608C98C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLlSIaOO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B8A10FE84;
	Wed,  4 Nov 2026 19:46:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF0B10FE84
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3D0D410B4;
 Wed,  4 Nov 2026 19:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D6C1F0093A;
 Wed,  4 Nov 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821568;
 bh=kxjspy9ZL+8t9BkjE4oKOSwNeWEzIszQIFkvCyGQz+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JLlSIaOOfmwiRkeMfAeymPb8iqZ5kInrVHmUVrnnSNEg7lKvYgz5ntp2noxoE0tcJ
 l5uTCQ7sZmy2Suvt1hJw0D93TFqGQt7g7UN9fx3rFBYNz5jEhGOHAzzDl/HKKcMF7y
 bPv0idsK5N6TZfoeMHd8ziRguD5j+3OotTsy+8cQCJdsD1QGkEdzpqbTwliR57Yc3V
 fxjs3NO+XnhCmM3pFy8SWEJgMTtwqv6K2if/idg3x3m7xWzW6qCp+g2LXXBf9Og+g0
 Ua4thEtjj8fCnZQWbaPMAdEd00vW84we0g2UYCi2t1dBmB5PG3+uFhf7hHN8zgxJsf
 e0J4kSxqElnkQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@suse.de>,
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org,
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>,
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-debuggers@vger.kernel.org,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 15/26] scsi: esas2r: let procfs copy the ioctl
 argument of the ATTONode file
Date: Wed,  4 Nov 2026 20:45:54 +0100
Message-ID: <20261104-work-procfs-drivers-v2-15-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7201; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8l1z/REgMAV+eMaktVeRDOA8Z1xa02Gmz6227ra7RCg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS97mqdmnho4rGIo0E99Z2KN122Xz6mVdWe4x8723LZu
 YbCPfs5O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSf4CRYaOrxDlfxfOr+fIS
 TrSXHDvi2tTxqfj0PI+ZL6/JL+L3/crw3y9OLNn7yTulZy2MG07VmdU2mhj797PMstYzMkwvW7+
 ACQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the work of esas2r_ioctl_handler() into esas2r_ioctl_buf() which
works on a kernel copy of struct atto_express_ioctl. The SCSI ioctl and
the character device keep copying in and out in
esas2r_ioctl_handler().

The procfs file implements ->proc_ioctl_buf() with esas2r_ioctl_buf()
and lists every command from EXPRESS_IOCTL_MIN to EXPRESS_IOCTL_MAX, so
procfs copies the struct in before it pins the entry and back out after
unpinning it. Commands outside of that range fail with -ENOTTY instead
of -ENOTSUPP now, a NULL argument with -EFAULT.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/esas2r/esas2r.h       |  2 ++
 drivers/scsi/esas2r/esas2r_ioctl.c | 58 ++++++++++++++++++++++----------------
 drivers/scsi/esas2r/esas2r_main.c  | 44 +++++++++++++++++++++++------
 3 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r.h b/drivers/scsi/esas2r/esas2r.h
index 10101f50b282..4d75b8adbb3b 100644
--- a/drivers/scsi/esas2r/esas2r.h
+++ b/drivers/scsi/esas2r/esas2r.h
@@ -964,6 +964,8 @@ struct esas2r_adapter {
 const char *esas2r_info(struct Scsi_Host *);
 int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 			struct esas2r_sas_nvram *data);
+int esas2r_ioctl_buf(void *hostdata, unsigned int cmd,
+		     struct atto_express_ioctl *ioctl);
 int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg);
 int esas2r_ioctl(struct scsi_device *dev, unsigned int cmd, void __user *arg);
 u8 handle_hba_ioctl(struct esas2r_adapter *a,
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 80ae5b9d45db..901c5d40cda8 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1279,37 +1279,25 @@ int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 }
 
 
-/* This function only cares about ATTO-specific ioctls (atto_express_ioctl) */
-int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
+/*
+ * This function only cares about ATTO-specific ioctls (atto_express_ioctl).
+ * @ioctl is a kernel copy of what the caller passed. It goes back to the
+ * caller unless this fails.
+ */
+int esas2r_ioctl_buf(void *hostdata, unsigned int cmd,
+		     struct atto_express_ioctl *ioctl)
 {
-	struct atto_express_ioctl *ioctl = NULL;
 	struct esas2r_adapter *a;
 	struct esas2r_request *rq;
 	u16 code;
 	int err;
 
-	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
-
-	if ((arg == NULL)
-	    || (cmd < EXPRESS_IOCTL_MIN)
-	    || (cmd > EXPRESS_IOCTL_MAX))
-		return -ENOTSUPP;
-
-	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
-	if (IS_ERR(ioctl)) {
-		esas2r_log(ESAS2R_LOG_WARN,
-			   "ioctl_handler access_ok failed for cmd %u, address %p",
-			   cmd, arg);
-		return PTR_ERR(ioctl);
-	}
-
 	/* verify the signature */
 
 	if (memcmp(ioctl->header.signature,
 		   EXPRESS_IOCTL_SIGNATURE,
 		   EXPRESS_IOCTL_SIGNATURE_SIZE) != 0) {
 		esas2r_log(ESAS2R_LOG_WARN, "invalid signature");
-		kfree(ioctl);
 
 		return -ENOTSUPP;
 	}
@@ -1350,7 +1338,6 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 			esas2r_adapters[ioctl->header.channel] == NULL) {
 			ioctl->header.return_code = IOCTL_BAD_CHANNEL;
 			esas2r_log(ESAS2R_LOG_WARN, "bad channel value");
-			kfree(ioctl);
 
 			return -ENOTSUPP;
 		}
@@ -1403,7 +1390,6 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 
 		rq = esas2r_alloc_request(a);
 		if (rq == NULL) {
-			kfree(ioctl);
 			esas2r_log(ESAS2R_LOG_WARN,
 			   "could not allocate an internal request");
 			return -ENOMEM;
@@ -1516,19 +1502,43 @@ ioctl_done:
 
 	}
 
+	return 0;
+}
+
+int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
+{
+	struct atto_express_ioctl *ioctl __free(kfree) = NULL;
+	int err;
+
+	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
+
+	if ((arg == NULL)
+	    || (cmd < EXPRESS_IOCTL_MIN)
+	    || (cmd > EXPRESS_IOCTL_MAX))
+		return -ENOTSUPP;
+
+	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
+	if (IS_ERR(ioctl)) {
+		esas2r_log(ESAS2R_LOG_WARN,
+			   "ioctl_handler access_ok failed for cmd %u, address %p",
+			   cmd, arg);
+		return PTR_ERR(ioctl);
+	}
+
+	err = esas2r_ioctl_buf(hostdata, cmd, ioctl);
+	if (err)
+		return err;
+
 	/* Always copy the buffer back, if only to pick up the status */
 	err = copy_to_user(arg, ioctl, sizeof(struct atto_express_ioctl));
 	if (err != 0) {
 		esas2r_log(ESAS2R_LOG_WARN,
 			   "ioctl_handler copy_to_user didn't copy everything (err %d, cmd %u)",
 			   err, cmd);
-		kfree(ioctl);
 
 		return -EFAULT;
 	}
 
-	kfree(ioctl);
-
 	return 0;
 }
 
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 75a70ae9441b..720be2a0907d 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -613,14 +613,6 @@ static const struct file_operations esas2r_proc_fops = {
 	.unlocked_ioctl = esas2r_proc_ioctl,
 };
 
-static const struct proc_ops esas2r_proc_ops = {
-	.proc_lseek		= default_llseek,
-	.proc_ioctl		= esas2r_proc_ioctl,
-#ifdef CONFIG_COMPAT
-	.proc_compat_ioctl	= compat_ptr_ioctl,
-#endif
-};
-
 static struct Scsi_Host *esas2r_proc_host;
 static int esas2r_proc_major;
 
@@ -630,6 +622,42 @@ long esas2r_proc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 				    cmd, (void __user *)arg);
 }
 
+static long esas2r_proc_ioctl_buf(struct file *fp, unsigned int cmd, void *arg)
+{
+	return esas2r_ioctl_buf(esas2r_proc_host->hostdata, cmd, arg);
+}
+
+#define ESAS2R_PROC_IOCTL(_cmd)						\
+	PROC_IOCTL_ARG(_cmd, sizeof(struct atto_express_ioctl),		\
+		       sizeof(struct atto_express_ioctl))
+
+/* esas2r_ioctl_buf() takes every command from EXPRESS_IOCTL_MIN to _MAX. */
+static const struct proc_ioctl_arg esas2r_proc_ioctl_args[] = {
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_RW_FIRMWARE),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_READ_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_WRITE_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_FC_API),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_CHANNELS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_CHAN_INFO),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_DEFAULT_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_ADDR_MEMORY),
+	ESAS2R_PROC_IOCTL(EXPRESS_RW_MEMORY),
+	ESAS2R_PROC_IOCTL(EXPRESS_TSDK_DUMP),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_SMP),
+	ESAS2R_PROC_IOCTL(EXPRESS_CSMI),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_HBA),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_VDA),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_ID),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_MOD_INFO),
+};
+
+static const struct proc_ops esas2r_proc_ops = {
+	.proc_lseek		= default_llseek,
+	.proc_ioctl_buf		= esas2r_proc_ioctl_buf,
+	.proc_ioctl_args	= esas2r_proc_ioctl_args,
+	.proc_nr_ioctl_args	= ARRAY_SIZE(esas2r_proc_ioctl_args),
+};
+
 static void __exit esas2r_exit(void)
 {
 	esas2r_log(ESAS2R_LOG_INFO, "%s called", __func__);

-- 
2.53.0

