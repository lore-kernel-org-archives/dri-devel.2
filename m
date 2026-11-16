Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IkSsWJmG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2658C10F46F;
	Mon, 16 Nov 2026 21:40:01 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C509310E466
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:39:54 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so167193a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865194; x=1795469994;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=RdAkVaeDBJDSzkUK7gNpSaAOngJyBeh25bThGVq8AiJA5FTe3EDJ8JrBaTBWGEmlhg
 XADHQ3lBYF5uwshUFMBw1LnhlTLzYUZHbR6yRbIMCm4LTOiiZBnCoL5SGBZkBmOEY/B7
 IDVRJtm8hgURN9yM7/R7TB36SUFz3r0ReZ88UJQ9RjhzAxslzWbNJMBKS5WPeiALiFpm
 pfRGuo7BlOBSB9FNbknDkHH6i+hZWyIlUGH6AsSyfYh4nMa3IZ+Aj2yUokrQ8Rxm39jB
 thpapGeLhcHDKa89w7bcDvP+irmbsiEAJR3uZniXgQYq8n1GQ9iPysHzox/C764LjeSj
 zfoQ==
X-Gm-Message-State: APuU4Z/UE1ja06ZuPLxwx8Rju1fq5hhxXpvTDmPz/t7WEWlHZerxHHVR
 /r1AGo90zZPFTp/LIBDh3JS5HsM/PXpILSyvGXosqsQm8PaFYwVvIGk6ghJYkdw1YXEQmtdPSjq
 7CvTzyjJl4944uekix+zv5g1YrAfxJLVk80sKIA9Ge1D7Mb3JJla2TC5gPT/m1EadYY8+bfLBOo
 uDtYswiFURuwZzHyIu5VnVJdqOaf2e2NwiOCxwZ28HtHMdfxlMYUEjjdAld/PZBTQVVAw4nV5oy
 +r6pVpdtbHSp5rFx+IX
X-Gm-Gg: AZFdTZew7Q2Tz5pa6W/pfcZfYNaXt56LVYU27tgmBqFloSM2qUAqzIFZCbUtHVugnPz
 SrKf844x6CtVkVe7F5b21GVukkrvGKmPPxUPVKIWA7VqkE64XdSCSVAAgp3xgC3BHOKMCI9Pxly
 JVXdTl/2XtNZuJh2Ydhq5Pl7XJy84Gf4v2y2etmii7zS8UbjBQvs7VuLBZOnNs0mCV4FFaTZnPP
 lAp+XmeUCuLE30j2KlDeg/9YYhXdUruE02s10p4QVE8suSTslMuiqqk2Uw0SRLCekY/Lpo7i1md
 X2YT+gv9sc23MX2aAR9zbWjiJNW877euk52MrD2cw2Vvhe7ji0fjsencnHyI6Hx6HWHAfLhgaAm
 +tnaa0lF09jx1JU2CCvhiJiFoqZVHM0GJ7JTrXMYggcZEzra8dyJeY8WNlT8wkxnWODb0vkE6as
 taGOWkzE4EJFFEAynVoedLATpbcXPqhR5D
X-Received: by 2002:a17:90b:817:b0:3ae:8983:4ef8 with SMTP id
 98e67ed59e1d1-3b3abafb5b6mr304842a91.9.1794865193990; 
 Mon, 16 Nov 2026 13:39:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1c4bcf708sm3254182a91.3.2026.11.16.13.39.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:39:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3425098ae4bso237025eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794865192; x=1795469992;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=IkSsWJmGe7/4imUAcLiESXe++6VXwjxs0qHOthhV4z96W+NNV5savHAv0M5EAuGiEe
 wQP60JxNvjUq1giQzYoTiPlMN7Hfs0NYQwvjgfBAFUpzWG8trhfTSWYDStCZVvn2x2A2
 f/iWp33kqC98FTF48kpEz/paWQOqSUY3LX7OI=
X-Received: by 2002:a05:701b:4208:10b0:1b3:b3d5:566f with SMTP id
 a92af1059eb24-1b53a3d6f36mr612973c88.11.1794865189315; 
 Mon, 16 Nov 2026 13:39:49 -0800 (PST)
X-Received: by 2002:a05:701b:4208:10b0:1b3:b3d5:566f with SMTP id
 a92af1059eb24-1b53a3d6f36mr612946c88.11.1794865188415; 
 Mon, 16 Nov 2026 13:39:48 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm35390371c88.11.2026.11.16.13.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:39:47 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Tomas M <tomas@slax.org>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 yunfeng.li.nb@gmail.com
Subject: Re: [PATCH 3/6] drm/vmwgfx: include legacy hotspots in GB-only cursor
 images
Date: Mon, 16 Nov 2026 16:39:44 -0500
Message-ID: <179485275605.3430538.13640938739279005533@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-4-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-4-zack.rusin@broadcom.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. Applied to drm-misc-fixes.

z
