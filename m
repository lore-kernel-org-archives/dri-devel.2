Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7A606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=krTo/vNI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B3410E55E;
	Sat, 24 Oct 2026 23:00:48 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A987C10E13D
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:57:53 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so14536955e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875472; x=1793480272; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mphibqgTFFMm6n9Ocw8j+xegMNjz+2yKf+Knt+msTKc=;
 b=krTo/vNILbb9kNrGDJ0lmaQWuM853/C3BT80WFUxWDMFz7DZLEtOGlg2UcbkOov8S7
 RBDeuB6OXuazHPv6dwoA1rVxCICDxiTyvMDg7NiVRiLxCMKJph/ZQYiOOsxUMOCwOeyt
 pLVOOBleRCrEVCe0ngYTipVKdpj4zrqF8HwRkdm1DAqamwoN6aHKYH7A31jBI3TBYcco
 hAqZibfhfqRzvnsKfx8Of5+ma6QMukcFW1PPPts4dOHi1vJJycPr0Ws97qvOCz7I6Es9
 5GG0hlDRYWBK+mE5LPLETo6R1SGDiVF704lBUYAGrqtsvdIVwO2a8z65X1mrPU0JfaxR
 6TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875472; x=1793480272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mphibqgTFFMm6n9Ocw8j+xegMNjz+2yKf+Knt+msTKc=;
 b=HuX5ngRu7rU59aHkDW2N7R1SeNzoAYz+vfKqtY63gxIgTNi+N29aea8Coc2bqCNbC8
 S0Xiy/cqIwBiNoSRnHa4bI7HXgRAlZf9Z9bPoF/MjrQqgbJYEk9NVe//6wVoBJ5ux8vi
 AnuaLPSi1fMQXTie0b3aOYWFD0GG1gI+95yVHOLCj0CkjJsg8lFU4bqtvQGBGwbH/JL1
 PBp5OR4i97HmrdLKkC+IsoenxrhrdCCzrl4V89BHrbxTx74mmO90UFOLrrBR8+M5M4H/
 7AXQwBEOURhKg5tN2qXR1Q+S0Jafo0lb0jOs5C56TUQmM5L7UNQxXFa+3aHhgrhKOZ7f
 LPwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYL0B/RWyEwER3D2W28vqv+bteVV36RNEWR1UKHXLaKCp1nCM5Dke4l0kV0806xVS+3rHZXKu7hqA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXh55A7YA0VQRD0b31DaYGQ5ADgLTjw5QcPcbIBkCjqf8t6sFc
 K0CPj2lNzFeO7gxFx2IMhHmSF7Fzo7cGGQktm/+JOMFfTmHGrR+q7hY=
X-Gm-Gg: AYBFou2cvQaQeB+ACnhbZY2l+qxcyKrm/Fw/LxXKazHfmN1AmaGBeS0BnPolarnpvpx
 fbn0Vhy66UzT1Vlv2aS0kS4mgBdwi7tVJo4xpNMGzdnvy2p/cjndNKSwEH1LEHF2wfNRB6jGcH/
 2wUpZw2Dj3fAtgU7lmWHADbbePlQRZm0cWCLnk4brcz7jPUOhgXq4lUZLf1PGumP+7T/blN7W8x
 Ea+V5BvDer5VDUq/0gAoG3sPnShJA5ti5NAhF2B3isCnZbnyybtD54Z8h4qZ/X0jcuv779HZzy5
 4j0ZW6wAfA9i2Wd9sAX61a77F9G+yHrp6B0Bpx9v8LX22WzAIDJOQBT63IvR9vXUM9vE/09yILz
 F46WQHKDunqQdk6/g5aQ0Y6xaQ1jVysNWQzM8EpjTmN22aJ9ZN4vztwxYXlrQqcs6E2ym0Fjowv
 RccRBrd1B/8hilaX6fB2pxmCNsJEc0gXTkwPW+2U3AjrxDQMCuB/hNS66YUVhTdXJW2BuILurrL
 ARxLYpYMVZHdx47OKSEfiYcPZvqGJZ+0i3XtWeBF5yBcA==
X-Received: by 2002:a05:600c:34d5:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a35aca2b53mr39027755e9.25.1792875471790; 
 Sat, 24 Oct 2026 13:57:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a56992dsm71004965e9.6.2026.10.24.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 13:57:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] drm/nouveau/disp/r535: validate ACPI backlight DSM return type
Date: Sat, 24 Oct 2026 20:57:49 +0000
Message-ID: <20261024205749.4045480-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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

From: Tristan Madani <tristan@talencesecurity.com>

r535_disp_oneinit() evaluates ACPI _DSM method 0x14 for backlight data
and directly accesses obj->package.count and obj->package.elements
without first verifying that the returned ACPI object is actually a
package. If firmware returns an unexpected type (integer, string,
buffer), the union access reads unrelated fields, causing undefined
behavior.

Additionally, the loop accesses each element as integer.value without
checking that the element is actually ACPI_TYPE_INTEGER, and copies
into the fixed-size backLightData array without bounds checking, which
can overflow when firmware returns more elements than expected.

Add type validation:

1. Check obj->type == ACPI_TYPE_PACKAGE before accessing package fields.
2. Free the ACPI object when the type is unexpected.
3. Validate each element is ACPI_TYPE_INTEGER before accessing its value.
4. Check that the cumulative copy size does not exceed the destination
   array.

When a non-integer child or oversized element is encountered, the loop
breaks and the valid prefix is forwarded. This preserves the existing
behavior of reporting success for the _DSM call while preventing
out-of-bounds access.

Fixes: 9e99444490238d ("drm/nouveau/disp/r535: initial support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173fc2c1..267cc098ff769 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1556,15 +1556,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 								0x00000102, 0x14, &argv4);
 					if (!obj) {
 						acpi_handle_info(handle, "failed to evaluate _DSM\n");
-					} else {
+					} else if (obj->type == ACPI_TYPE_PACKAGE) {
 						for (int i = 0; i < obj->package.count; i++) {
 							union acpi_object *elt = &obj->package.elements[i];
 							u32 size;
 
+							if (elt->type != ACPI_TYPE_INTEGER)
+								break;
+
 							if (elt->integer.value & ~0xffffffffULL)
 								size = 8;
 							else
 								size = 4;
+							if (ctrl->backLightDataSize + size >
+							    sizeof(ctrl->backLightData))
+								break;
 
 							memcpy(&ctrl->backLightData[ctrl->backLightDataSize], &elt->integer.value, size);
 							ctrl->backLightDataSize += size;
@@ -1572,6 +1578,8 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 
 						ctrl->status = 0;
 						ACPI_FREE(obj);
+					} else {
+						ACPI_FREE(obj);
 					}
 
 					kfree(argv4.buffer.pointer);
-- 
2.47.3

