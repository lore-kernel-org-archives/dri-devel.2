Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21F60A2620
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pFfx2FxW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0E210E58A;
	Fri, 23 Oct 2026 06:39:59 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601C410E529
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:39:45 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso252333f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737584; x=1793342384; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zCs0TMoU/xtdfW2o//Qc3w2kO9KE9uGMF0SrdJknZZc=;
 b=pFfx2FxWl1jFA5kYXlhWEYJf1uplbxqMPGniXRvQ9E7rhCKQTp15ylpLCFVBYGsD2h
 uPBvYCHamHRd/9RoyF1gNCMGyK8YyKH1lXPWPNgzxwj3CVGvpDCm3rruJvllbRKSSKLS
 nl1Gnvu9z83anHV4SgKnYF/Zcw5x9v2Uoggu1rUdQa2LDGmsOxysxb2MZAiRttjIBcyi
 +LK1NXl5a3L347gKhWeX6FrN+HsDXmdab78pcqcWLq/eS52WBye3wT5NFfULVLqDqrBh
 rfy1Ser+JBCkF9nGqs0gSEwfM30X6GIZ3TBWTz1bXAT9dg4xM04KJo6Uf+9eiBVChlQv
 zI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737584; x=1793342384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCs0TMoU/xtdfW2o//Qc3w2kO9KE9uGMF0SrdJknZZc=;
 b=RQsdpwekthIeZatB15YADljiY/WwgqiiHuxyk6sX29DtJjnJUd8LjMKrWoxCJZSL++
 Kx4ny0eT+piLMadE8YYSzjk857YWTVNUpfSYkLV5pRtKOZqT0qJCq1XtUwAnMrHEV/zK
 JPo43urcNzBp26eibl2tagrw6dGpery0ynwq069WrYkSX5Nmgu/g/QecT66U7hcK3YCv
 fT9teg6Gc0VqJjBDSfExm8fPHVlfQROr2KwYNMOvq865imIVhP2aWC1szNi27PTolqss
 R42/j+5Fdo6NEyPkO6ahaDjVczWLPnlxVAqIgADeu5iW6s/uah07hIIGgnsJ4iNmPUwl
 oVvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5Q0Yq1mhsM6DmmE2OH2UDjhLdIqDmRvXTQ/snV2M24HS4fZzcJwQ0Ukm4H/kgI/ShU+e1x9TTQNs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKB6Hy+mtQO4cZxpaMCfb3xIwO1MNKqV/S0KNzXhgmz7l06Q6ls
 l2T1e0P/EgRl1LLsl1rs0AkBeyWN8wf7xVziPFiQ19CwbzfaMEzEmqPt
X-Gm-Gg: AYBFou3QI8E5ZObg3Gv4mwhdM1OyI9tMvUw5EhmYtgTcFYk7c4epbhJIS+wgGUGZI2S
 fL6c7j6dUQvThHytEzurr/4Y8X/Elvh8WyapZmhwta7BHJkOmoOaJXlm9++pwGWsexRCCj/N837
 f1JCmp9n/AMxmNkolrazqmCIcNMNDcPdyEzgHC40Klj/Q9J1pKqKnx5YHK9kyc9tf63HnJSwPhW
 S8X6mI17SBmsQghxU1jlHUw4r8p7L1VxGGhZjqdhobyIjcszRudn4CvEMvFRO1fxVTT49kSdcWy
 Nf/ipK4DoSBainT7wXRfhJ1Ut9zLiYmkvSor6PHemk24YIp3l/DCTbaXoieD0AfBx3L54AjDLRv
 yH6a8jKNMmsIXqmaDpMiF7hutyqJfbpUpDI3uwGseYbJ7618cMksideqs+XUb12CeCEmrFD0RxF
 yY3ztPI4tlimy5cGHuD7lnyH3St9QJscCYvAQ+8fAE6yZtUC8g/qx+9B+dEj4CCyogZXApEHdFb
 Ri53eN4P7hKqujydv5xyhsVU3mDqQgGurew9RLS11YHDiAIHAArZPhUDpb3NEXhm28lniWjdFfr
 zd+PZoBSmAmBu3PJj1yO8rztM1HzXQ5SH/wxozqPxkXw3RkrGDUj9syJrczhcGYNhw62u5GIqpQ
 b0Jw=
X-Received: by 2002:a05:6000:15d9:b0:48d:ff0d:cfa5 with SMTP id
 ffacd0b85a97d-48e385b9322mr977703f8f.47.1792737583628; 
 Thu, 22 Oct 2026 23:39:43 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:39:42 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:27 +0200
Subject: [PATCH v3 02/16] dt-bindings: remoteproc: k3-dsp: Allow a second
 sub-mailbox
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-2-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow specifying a second sub-mailbox that could be used by the firmware
in addition to the first one, which is taken by remoteproc.

This is required by firmware that doesn't use rpmsg for their
communication with the Linux kernel.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v3:
- Initial version
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 278b88b7f906..d6319c8e96f8 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -51,10 +51,12 @@ properties:
 
   mboxes:
     description: |
-      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
-      communication with the remote processor. This property should match
-      with the sub-mailbox node used in the firmware image.
-    maxItems: 1
+      OMAP Mailbox specifiers denoting the sub-mailboxes allotted to
+      communication with the remote processor. The first is the one the
+      remoteproc core uses and should match the sub-mailbox node used in the
+      firmware image. The second is optional.
+    minItems: 1
+    maxItems: 2
 
   memory-region:
     minItems: 2

-- 
2.54.0

