Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC969CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2187910EBC8;
	Tue,  5 May 2026 22:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Pfmnd1uW";
	dkim-atps=neutral
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBA110EBC8
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:28:03 +0000 (UTC)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-651d6347a69so385916d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020082; x=1778624882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rj4d9IL+hL4lojp3+Uqxu+QGmAPGmpw5YIIrwS8C56o=;
 b=jOJc40irFdoL2bLyDCUzo9EmQCiDpDHcylOb/FFrtjy8npSw+m/WiC2HvPp491fw93
 8czrfFr88bx3Tuz4rwI2+M4KuO2rzTBXObpqrtH4GcT2pCN4N0lQrD/yOHEfwDBmfKXo
 d+p5wS/PeBzteAMcvqfKcn5qQUd1cZHTb9JngMuhNbbItA8rDrrdW6jbxYi2xT97xgkt
 lRpnocbaHJOZA24NE8oLBQIHsY+iddMHk7wdst8f1C8HIIJy6m6bIy8v0qw433XBypmg
 4XDpKDlzKzGy0Glt77gHxP9blhnPjoVOcU+l/a2GzNxvhFNh5Peaez2ZL1MCyA1PgPHa
 /HlQ==
X-Gm-Message-State: AOJu0Yx+bewvFyv578ClCouIZbw0YjPBt1jiLk+ggsM81maXqQXuwIEq
 21isx2/EuMRLZfnVZVx0Hyo1Sb8tb5Tx0vxrX26vOB4/HKMrpnFix8r9XvWeWPZqocHCGCzPYm0
 nxIk51QUJITjV5GiOcUzU0d0mZKnv8Xx69abgTF2dvcBZhNSo4uZaQxQgeZmODM4wUf1Id/J4gi
 x3/lfIXBy9atUhJ31DkizL7KrZt567NTY7zuiPdemn1Wp6EV7AAljgfMFltlg6IdRgIiZrnQq3Z
 97IMNKVrPxaM4SFwXVi
X-Gm-Gg: AeBDietiYrK/kGad+Y7vAqcDEwdL9haP8RRYc+BewscF9PCpbrv8gbJ73hnM/cAcRfj
 AxnPQ9IDJkJIncaVkOvFQ+zlpET30JDGHHbDBSxJ8Jt/5gdNSDMGNXesocmEnDMbr1r5m9trfTO
 w27I5G2f/Piq9ZYSy7WrF9YZwMy+2IjANt6yI90ICp0HHe3aehQrJBRyz8PyNjY1snaLKSnTHUi
 QF2fg3BF1E/oosgZwhd/rCXfrPg4IB0PnpLjACUy65GH7iAsI7LQ7K0jaR9KkedUsI2pwQT+zM8
 Yzegc9Su+FjRJYdOOiKyc0evskDt+BKFI+RpuL0105OIYqTnkpTRBHswLTpSqP9+MtwQumqZFyE
 UjDW+YS8MYSE39ZrQUB+FPsEng2Xl7iV2bXykItOSw7jjrSkSJS+I0MjLagzVAAVuiZYB5Vyaav
 tSe3eN4VVoSj3f
X-Received: by 2002:a05:690e:c4e:b0:650:14bd:f344 with SMTP id
 956f58d0204a3-65c7a35d517mr846098d50.14.1778020082273; 
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-65c7adc628asm24848d50.4.2026.05.05.15.28.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e423a05c8so10741241cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020080; x=1778624880;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rj4d9IL+hL4lojp3+Uqxu+QGmAPGmpw5YIIrwS8C56o=;
 b=Pfmnd1uW6MjFt5jmBzjJJpVd09J7XkKl8uGugr2Ra5MP8Xqr4HGaCXQZc1tdbC1m/1
 S6IO8tVRY7P7tsf4B7bm/aJIWEpn3+1NTJz4Wl+7tDXGcRWsx6AcmOLoT55iiYVtdwAt
 1MyhBZlsRkMh0W6KNJGJBcDrJQZ6r5Y409DHA=
X-Received: by 2002:ac8:7f51:0:b0:50f:ad91:8906 with SMTP id
 d75a77b69052e-513052ffe4amr74220891cf.20.1778020080048; 
 Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Received: by 2002:ac8:7f51:0:b0:50f:ad91:8906 with SMTP id
 d75a77b69052e-513052ffe4amr74220601cf.20.1778020079508; 
 Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 10/12] drm/vmwgfx: skip hash_del_rcu when validation context
 has no hash table
Date: Tue,  5 May 2026 18:22:31 -0400
Message-ID: <20260505222728.519626-11-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_validation_add_resource() conditionally calls hash_add_rcu() only
when ctx->sw_context is non-NULL, but the doomed-resource error path
calls hash_del_rcu() unconditionally.

The KMS validation contexts created with DECLARE_VAL_CONTEXT(_, NULL,
0) in vmwgfx_kms.c, vmwgfx_scrn.c, and vmwgfx_stdu.c never add the
node to a hash chain, so the resulting hlist_del_rcu() writes through
node->hash.head.pprev which is freshly allocated and uninitialized,
corrupting whatever happens to lie at that address.

Mirror the conditional from the add side in the cleanup path so the
node is only unlinked from the hash table when it was actually added.

Fixes: dfe1323ab3c8 ("drm/vmwgfx: Fix Use-after-free in validation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index 35dc94c3db39..45fde7ec514f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -309,7 +309,8 @@ int vmw_validation_add_resource(struct vmw_validation_context *ctx,
 	}
 	node->res = vmw_resource_reference_unless_doomed(res);
 	if (!node->res) {
-		hash_del_rcu(&node->hash.head);
+		if (ctx->sw_context)
+			hash_del_rcu(&node->hash.head);
 		return -ESRCH;
 	}
 
-- 
2.51.0

