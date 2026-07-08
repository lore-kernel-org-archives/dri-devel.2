Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF6DC44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC4110F3E9;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTYTXZmR";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE3A10E56E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:18:54 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3860f32307bso25193a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783491534; x=1784096334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
 b=BTYTXZmRXEGLSW08x0qkRr3samnRGgPeroXCqZi9voM8dc9/npppgcuRhrpaneqGRR
 7vLcoc3aKfcapsWLsY/z/LVB3YJrxT+IvCOSke+ht17tlUxqSKJ5SCZVus0ZgHE0yyBY
 Ti4SHjX+SgUJwpZqusEpFq/RErbR2DxFzOIAXAYBpZqi5xl00nqIKM2oJYsNbCKibKwE
 Jn7nLt3ynYiiCcFZXtl5E6IpH7+/poEQVIyKPbc7Lr4DHPpGf8R9C/FBkye0O2etAdAt
 RI80u58FakzoMwL+MwyR4KpuLc0ID8fNomd95PhyTzPP4gx47yRf5I+9982aaF1QZalw
 H/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491534; x=1784096334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
 b=OoyzaG2MHHlkNZTtWh8LXaoO/J/q0+r9PnvubTYYNF4IPVBByXqb/JzhOaWwKmLocw
 cdHP9aoxw8+esvmCe7k6c0D6As3IFrO9Cxk5hNMaej/Hb44P2YiSzZK/suCG9XSU+PIV
 Jt/77d/3PKN3gPhktCFgD9mhC69jNXuq4HHccwcOooDT/CfzyaVjBrQRfbylEKpzj1pI
 M0Iia7WJIb/yvjlna4U+re3iE6fR7uJHaw9rUiyEoRUR8HiHwM1dV9ZBYNNsOU50LJRU
 PIN6vRsA9Cud0AcvD+VtvjR1LVA16OH7bKusqg/M7nlhEGC4xSQ4jb5rY3v8z51sb0AM
 Bkww==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKQimkDMqhDVrbu9jfEoqPGBWd5KXuP+J7u2uirSOkLtVzYh1L4F8mse5bCm6yFLd3WexIKaUdPBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyuq1zC63Rf4NUq6cuSXOIrMXigUUJXyIVjH1ioXELu/uUkQxA+
 jMWs4J6cvipyxjSznOc60Jg7vFNUX6ycwDar3Y8mZ+A9oBjb1nVzi5aU
X-Gm-Gg: AfdE7ckjx+EpGs54/MVk6XZee83r8vexN3lf2doJ8baIRAC0nSpk2mDU25XsaMaOpvo
 F8Tvz3LqOMVjsZPyUFkx4ViiF7BcvnK9Q5UafjNdFX/IzUVZvjYK07qld8rVv/LB6uyUs3GLNNf
 oS3a4nQ/gO51OzRigiqaQ9GtCR9pakSPt7lG21AFGzIIXEJggSQ45NSg7HSmO9ATz1tm3ngMeMW
 HAvMIkCW3NHLwOeLpl+BXPbB8bIx+hLs6OdNVbS5Ch5TJnZ0euxUFuZzDlxCQ23NBOQLytqNmOj
 dWQC38InsXlHmYcAiTxkZXXjoYclOJ2ey0jvNk76Zw0xi8ApVPzY70+0BKIB1HqtGmxWGrC6+oo
 LC8v9SLBJogGXPQxYY5eXvvmZ0YReZ0UjLg9e3y+tpxjp+Qp/j1zkZPnpDQy8zg3apb40cSJrLI
 /9DFZUR1LLLgc9Rikp/w==
X-Received: by 2002:a17:90b:57cd:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-389417e432fmr977538a91.4.1783491534182; 
 Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
Received: from kali ([122.162.146.188]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117d847e17sm12888463eec.18.2026.07.07.23.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 23:18:53 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
Date: Wed,  8 Jul 2026 02:18:34 -0400
Message-ID: <20260708061835.111986-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184444.D4A401F000E9@smtp.kernel.org>
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Sashiko AI review of the previous fix flagged three remaining gaps in
the discovery blob parser, all stemming from the same root cause: the
ip_discovery_header pointer itself is constructed from a firmware-
controlled offset with no validation before the cast.

  ihdr = (struct ip_discovery_header *)(discovery_bin +
                    le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));

This offset is a firmware-controlled u16 read directly from the
discovery blob's table_list, with no bounds check against
adev->discovery.size before being used to construct ihdr. Every
subsequent read from ihdr, including num_dies and die_info[], is
downstream of this unchecked pointer.

The other two items in that review (unbounded ip_offset advancement
via num_base_address, and num_dies exceeding die_info[]'s capacity)
were already addressed in the previous fix.

Fix by validating the table offset in amdgpu_discovery_get_table_info(),
which is the common path used by all callers except
amdgpu_discovery_read_harvest_bit_per_ip() (which reads
table_list[IP_DISCOVERY].offset directly rather than going through
get_table_info()). Add the equivalent check at that direct access site
as well, so all paths that construct an ip_discovery_header pointer
from a table offset are covered.

The check validates the offset itself against adev->discovery.size,
independent of any specific downstream struct size, since
get_table_info() is shared across ten different table types
(IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
others) each with differently-sized table structures.

Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b4ee5fc8e..9b55c56cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
+		dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
+			le16_to_cpu((*info)->offset), table_id);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	int i, j;
 
 	bhdr = (struct binary_header *)discovery_bin;
+
+	if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=
+	    adev->discovery.size) {
+		dev_err(adev->dev, "invalid IP_DISCOVERY table offset %u\n",
+			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+		return;
+	}
+
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
 			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
-- 
2.53.0

