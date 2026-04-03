Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB3E85367
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE07A10F364;
	Fri,  3 Apr 2026 14:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FLTvtaiS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B1A10F355
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775225593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zCsOheHk8XlC9CSFSmzc3izuiVKcS+6jE7o78F0/vE0=;
 b=FLTvtaiSWxQviBvxU4h7/A+XbG3am7WWlQ2wB8YCHyn0ClAEPCQJiSUrj17HebJrE994mN
 MVgSQo+1wfZ87acCzH6H5WqYi+C/ZyaRqFaJrt5SEiCVGDvyKidPVbDqttZYp8ozVMknBl
 3P03nWtE9B90+xBCTBBglUItlOuFaOI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-yCve99sRNFyrFfCBYsQ0Og-1; Fri, 03 Apr 2026 10:13:11 -0400
X-MC-Unique: yCve99sRNFyrFfCBYsQ0Og-1
X-Mimecast-MFC-AGG-ID: yCve99sRNFyrFfCBYsQ0Og_1775225591
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d3bea3aa34so291576185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775225591; x=1775830391;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCsOheHk8XlC9CSFSmzc3izuiVKcS+6jE7o78F0/vE0=;
 b=BQgfxjJbdvqw5I/Ts6GnLF74fs3kaV6lRnY1unu9ZwScWqa9fcIolkhY5Cf0axpatO
 dzk4bhd+03egZeyArHWQSuQIFIA1WeLmB7e4N3U4+JYQw3Wj0NRrhV91ByR5lk9x11fr
 bY213lIKNls8yb0icaHIp/ev16y64xQ7p0vKblIbhCKo1HIALLtXGC1xvdXWxtSSSu1R
 Tkpw7yXwKsVuUxNc3XEOUBJwdTeBr+vE2B9CE2Kjzix0Kq7RANWph/KEzwCIfDppHzqM
 ACX1FYvN6GZ4AaZPXRFZTNcRJe2V+/ETjTLVImiQdfHOUgPJXWAHSb9mRcxVXx9gX1jD
 rJ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo0kCG8xL3OS81OjfSPy9rHIb5j1Yil+xefCY4coU7NH9wteq3CXenQUJ7vYY8xdo8apJiSmPEdGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoGx9KsT5Yxruv1Jeqb3GNAgDdq6qpOnCJK8MGCG/6MpQ6WZxy
 hKZ1iERiHRlaxFybv0cCfBwGrXF6tDDiF4hrR89vNHN5ytsJymq8VD3+3ifsPGdUeQvN8QvZGjb
 6h8x8UpTXKh9odLTa68Z+ExrBvTfXJM+hhRrDVZ3a5q7R/byYq5abFElvOmn31wY0gSqJqQ==
X-Gm-Gg: ATEYQzy6TxmCItqmGKi2vNHtzvODhhokEMlWFo1d2Tn6jyHIjQCJDtNXRfGTL55yqEH
 xCDlpa68/jVBdoWHYBAl81QtoobMRYONEKz/N3NTSO7BErSBHVo+m+9cL5vsyf5YCrR03WABXe+
 hb1PKHiaZ1axo3tQP2M+lHJF8MSbGIjquAVSLj68mLEXXfvdJ0XWME3DM4pPVKQqV190Z1kMXE/
 pd+GwKaVQ4cBOhyuUmZUidau+K3FFPYmUTiYEYUA36ZNaaE7Vuo9Ao6iAKoKZ+B7LWhiVoUVz/9
 tJqQsCJhZVckvSLrESDLofHrmJRgnssar8+wMeULzKI2fl4SGUgBMUJCQdcdmrJ06JFalxJLF/W
 gJm8dnDJLcVWHuTOpLtM9jw0wsT/6SUn6PnHunRijTQg+Mxo2bpoWAtqtyACGgpA=
X-Received: by 2002:a05:620a:470d:b0:8d0:176:58bf with SMTP id
 af79cd13be357-8d41ec0d06emr460638585a.63.1775225590913; 
 Fri, 03 Apr 2026 07:13:10 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:8d0:176:58bf with SMTP id
 af79cd13be357-8d41ec0d06emr460628785a.63.1775225590198; 
 Fri, 03 Apr 2026 07:13:10 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net.
 [100.17.19.56]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d5336aa9f0sm21287085a.28.2026.04.03.07.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:13:09 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Subject: [PATCH RFC 0/2] cgroup/mem: add a node to double charge in memcg
Date: Fri, 03 Apr 2026 10:08:34 -0400
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNz3eT0ovzSAt2U3NRcXSBOTtdNyS9NyknVBSovAio3SDM0MEi0TEt
 LSjNSAppSUJSallkBtiFaKcjNWSm2thYATWgic3YAAAA=
X-Change-ID: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2jBry0cYU4WDeYh61b2XlbSLXHv3ox9kh2jmONzhxU_1775225591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

It was suggested previously[1] to introduce a knob for dmem region to
double charge dmem and memcg at the will of the administrator.

This RFC tries do that in the dmem controller through the cgroupfs
interface already available and walk through the problems that creates.

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Eric Chanudet (2):
      mm/memcontrol: add page-level charge/uncharge functions
      cgroup/dmem: add a node to double charge in memcg

 include/linux/memcontrol.h |  4 +++
 kernel/cgroup/dmem.c       | 86 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c            | 24 +++++++++++++
 3 files changed, 111 insertions(+), 3 deletions(-)
---
base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
change-id: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>

