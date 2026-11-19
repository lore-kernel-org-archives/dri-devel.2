Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA9606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMfAsoA+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD3A10ECF4;
	Thu, 19 Nov 2026 05:54:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4622410ED05
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795067656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yy6UPA1x+dgBp1oYwsbJqoBQ2EhZbFzvPu9SCMCc1gU=;
 b=WMfAsoA+zqI328xpzbFsLqOAZzCvooGMABpLQ33ymrnOOwSX05qJvals8VixrG46LmwZFk
 eJB+vJraLjLBSnUqvCKW9oRJ+wKODxhlhoXtnMix6uFmjrTSOCHzRamfbl5v4QOgBJMdSI
 BRQw4W2/2SI17XASKU3e19IGLfida8Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-Q9-NWpUJM-6AemZf8Ep8cQ-1; Thu, 19 Nov 2026 00:54:14 -0500
X-MC-Unique: Q9-NWpUJM-6AemZf8Ep8cQ-1
X-Mimecast-MFC-AGG-ID: Q9-NWpUJM-6AemZf8Ep8cQ_1795067654
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e94f72fb9fso15797775ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795067654; x=1795672454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yy6UPA1x+dgBp1oYwsbJqoBQ2EhZbFzvPu9SCMCc1gU=;
 b=T3j4QOhkpTGFB1xBES08RWew/k9AyQ4rn5XqXGvDCPeTpt7L5EBAXIEYDyvIIwMhiv
 u7qIQYAyHCCccMWQDPabb1IW7GpD0gEJgga79B7HLjBn9up5McO2erc2Ygc30vJ+cZu+
 pJXAN+M4R3Oi1q73TZT+tpAs9BopBDcWgpvwMSN7u7Lt2GA5g6pF0/UnL5J+SWrwgK6u
 3uCggzHL1PxkfLLmyYw9H/T1CBPK6EDSsirVkBCCDi6UrEzotqjAUzY2ivn9va2Q3duk
 Xtle5AqCNqmHM2Q1rU8WiBj4KoQgRTe9BDmelWk//0LLI6K3+pBzbg2D43/y8aBF9Tgf
 dUJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHeu9EoZ/wZUhSeJXnK26N7kMfBhwjAQUM73oupb8CoN9ADkpl0D+j3OucWK4lI9nRZ5xWO2aXeuac=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/0LyFc42WxtZpEcd5wcxfRMoAO5mhMLyUdqc6melH2y1oXlvJq
 LbHLUCOkRKVESyNHg8xshQf7GlgGOOCDNY/bBNekOVA5GRSmemksGoVYLp9bukUBWxtWRO/mQ92
 bSnKzhND0bckxnCLYC+uVzOi6OwBAUzvRyxxeZqpg/LheHxb9gqyc0ZIgEW4jmjGUhoy5iw==
X-Gm-Gg: AZFdTZe0FILR+MNa+LXfjQ0dV3tIIFUe4m+UdvT1deCy5nuF3zsXv6bAjH4O/o5PKi8
 Dy1xQ0RbfCA79qIziIzJK0aGPZ8ofFcgF8CUyTMiT04FZNdKemItKZb16/wYxTNDyqB+uWu9t0M
 ujJLa7cJCsyMzjJ3NzJmoIX5SNiZCKs+x2jSP8HrqtsYmwvT73a33o+GM1YY+aCh7p9A1Mv0DDL
 4Fh6Z/RURRtIy5CUz3qI7KB+c4TABeWv6K1wJwFlFXV1R3kOaZtKaMI3/27It3J8/V71ky2zWlE
 7rL7zADq0p08v/5CFJYI8C4fGkbeogBkJNj0Wa24FBjThRYR5y0f0nXdl5KiSEE5nYg5UCJ6GE4
 UUShmy1MW2cfwAm+Cyzb9prnBDuFZDOkTNXhMSJDRG0ejGhz56z/wX1TXo0sYCNSn/Dc3lFpIiR
 9pD7bBdLLSfaoIMw==
X-Received: by 2002:a17:902:ccce:b0:2ef:f652:a08f with SMTP id
 d9443c01a7336-2eff75352b3mr49821615ad.42.1795067653669; 
 Wed, 18 Nov 2026 21:54:13 -0800 (PST)
X-Received: by 2002:a17:902:ccce:b0:2ef:f652:a08f with SMTP id
 d9443c01a7336-2eff75352b3mr49821325ad.42.1795067653185; 
 Wed, 18 Nov 2026 21:54:13 -0800 (PST)
Received: from localhost.localdomain (122-63-66-168.mobile.spark.co.nz.
 [122.63.66.168]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6183f8csm23799715ad.31.2026.11.18.21.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 21:54:12 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com,
 ivan.lipski@amd.com, george.zhang@amd.com, adrian.betschart@cinemaone.ch,
 rodrigo.vivi@intel.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: [PATCH] drm/amd/display: Fix pdev lifetime in
 dm_test_conn_init_ctx_alloc()
Date: Thu, 19 Nov 2026 18:49:18 +1300
Message-ID: <20261119054917.184758-2-ltao@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YfHWJdCjKN4_gs27-iZUeRkC70Spf9zJuH2Gwi7fovU_1795067654
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The pdev backing memory is currently allocated with kunit_kzalloc(),
which ties its lifetime to the KUnit test context.

However, pdev embeds a struct device whose lifetime is managed
independently through the kobject reference count. This creates two
independent lifetime management for the same object: KUnit manages
the backing memory, while kobject manages the device's reference count.

Although dm_test_conn_init_release_dev() is currently empty, the
embedded kobject still relies on the backing memory remaining valid
for reference count operations. If KUnit free pdev while its embedded
kobject is still referenced, subsequent reference count operations can
then access the freed kobject, resulting in a use-after-free:

    refcount_t: underflow; use-after-free.
    Call Trace:
     device_del+0x29c/0x410
     device_unregister+0x17/0x70
     i2c_del_adapter+0x128/0x1b0
     release_nodes+0x4a/0xe0
     devres_release_all+0x9e/0x120
     device_unbind_cleanup+0x26/0xa0
     device_release_driver_internal+0x1b6/0x240
     bus_remove_device+0xfe/0x200
     device_del+0x179/0x410
     device_unregister+0x17/0x70
     kunit_remove_resource+0x93/0xc0 [kunit]
     kunit_cleanup+0x49/0xa0 [kunit]
     kunit_generic_run_threadfn_adapter+0x21/0x40 [kunit]

Fix this by allocating pdev with kzalloc() and freeing it through
the device release callback. This ensures pdev's lifetime is managed
solely by the kobject.

Fixes: 7db85e4b053c ("drm/amd/display: Test connector init")
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f09e2a72c534..b43c4eff2bef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9659,7 +9659,9 @@ static void dm_test_fs_caps_disables_replay(struct kunit *test)
  */
 static void dm_test_conn_init_release_dev(struct device *dev)
 {
-	/* Backing storage is KUnit managed, so there is nothing to free. */
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	kfree(pdev);
 }
 
 static void dm_test_conn_init_unregister_dev(void *data)
@@ -9667,6 +9669,11 @@ static void dm_test_conn_init_unregister_dev(void *data)
 	device_unregister(data);
 }
 
+static void dm_test_conn_init_put_dev(void *data)
+{
+	put_device(data);
+}
+
 struct dm_test_conn_init_ctx {
 	struct amdgpu_device *adev;
 	struct drm_device *drm;
@@ -9702,13 +9709,20 @@ dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
 	ctx->adev->mode_info.num_crtc = 1;
 	dm_test_create_mode_props(test, ctx->adev);
 
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	pdev = kzalloc_obj(*pdev);
 	KUNIT_ASSERT_NOT_NULL(test, pdev);
 	device_initialize(&pdev->dev);
 	pdev->dev.parent = dev;
 	pdev->dev.release = dm_test_conn_init_release_dev;
+
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_conn_init_put_dev,
+						  &pdev->dev), 0);
 	KUNIT_ASSERT_EQ(test, dev_set_name(&pdev->dev, "dm-test-i2c-parent"), 0);
 	KUNIT_ASSERT_EQ(test, device_add(&pdev->dev), 0);
+
+	kunit_remove_action(test, dm_test_conn_init_put_dev, &pdev->dev);
+
 	KUNIT_ASSERT_EQ(test,
 			kunit_add_action_or_reset(test, dm_test_conn_init_unregister_dev,
 						  &pdev->dev), 0);
-- 
2.56.0

