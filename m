Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0155CD6E43
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 17:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F04710E344;
	Wed, 27 May 2026 17:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BKmILYm8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396A510E344
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779902160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sVR4w/bJZ+gLns5rGEscxsF0pfUh38oD7KsVlfT+LAc=;
 b=BKmILYm80s68pac97YWOOcvxGqynDn5Epjr/4kWpacPJR9RKsbdzZQZ/xXiGC1voEaXr9P
 iaUhkrz2DhHAPI7AvavJ9efSIqnBqBqOIZZTzfZu+DNMGYdXLgOtRJUNw3wrMFSycEy023
 PM9YLtWCYm0DTgy4L0+bXvvhnzFKfUY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-e4mBIj0yMaafX_Wq_lFkRw-1; Wed,
 27 May 2026 13:15:55 -0400
X-MC-Unique: e4mBIj0yMaafX_Wq_lFkRw-1
X-Mimecast-MFC-AGG-ID: e4mBIj0yMaafX_Wq_lFkRw_1779902153
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B778180060D; Wed, 27 May 2026 17:15:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.81.166])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC2EC180034E; Wed, 27 May 2026 17:15:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nova-gpu@lists.linux.dev
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-kernel@vger.kernel.org,
 "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl" <aliceryhl@google.com>,
 "David Airlie" <airlied@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH] gpu: nova-core: vbios: Fix clippy error in Vbios::new()
Date: Wed, 27 May 2026 13:15:21 -0400
Message-ID: <20260527171521.2406456-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: IIJc8xoDHJUf4RrJ6K6bmpjWZa04CEMVG_iokeewCgE_1779902153
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From clippy:

  error: this `if` can be collapsed into the outer `match`
     --> drivers/gpu/nova-core/vbios.rs:328:21
      |
  328 | /                     if pci_at_image.is_none() {
  329 | |                         pci_at_image = Some(PciAtBiosImage::try_from(image)?);
  330 | |                     }
      | |_____________________^
      |

There should be no functional changes in this patch.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/nova-core/vbios.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c0bc1008ed752..d38d7f138b49d 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -323,11 +323,9 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
 
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
-                Ok(BiosImageType::PciAt) => {
+                Ok(BiosImageType::PciAt) if pci_at_image.is_none() => {
                     // Silently ignore any extra PCI-AT images.
-                    if pci_at_image.is_none() {
-                        pci_at_image = Some(PciAtBiosImage::try_from(image)?);
-                    }
+                    pci_at_image = Some(PciAtBiosImage::try_from(image)?);
                 }
                 Ok(BiosImageType::FwSec) => fwsec_section = Some(image.data),
                 _ => {

base-commit: 2cf1840b0fa7637b6731fd554529f8d57ea34c04
-- 
2.54.0

