Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBBBFCD0DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF8610E746;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AdCftPIk";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C14E10E69D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:16:14 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c0c955a481so1667327eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773807374; x=1774412174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZvDiA5OjEH9jB/X3wjJ3qQao5asOiEdEuR+UFxLqYM=;
 b=AdCftPIkmTak36f5MKqplLgCKN/xKA0BwFvcaSekDdDEJnE8OxwmBrDSWSOLKxGK+n
 Fm3ja2fU9KBDce6IPtBC68QLuIVrcVHFsl1she29V5P4r2KXUp+YTVE78HJnNroscbGR
 qs6sOXtW5s40BoKOGpg624Rr1gMbixjuY/Gu62PFqeRJ5I57aUfqusLVDYBiTRSKmcSU
 451LkeqvT16Fuu1yiC3fJwymCnyhcwF/OK4ASuabM9HjYzrsCSQHFYASWRGoTpLVno6b
 EJb5RMNtQ8htTj/+aNoh1fSRaPCuGdB7oP7QBCjDVmf8+IbVFlNV0gNruY4IoPHBuxFf
 gkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773807374; x=1774412174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZvDiA5OjEH9jB/X3wjJ3qQao5asOiEdEuR+UFxLqYM=;
 b=BNuuMXvv/lfIpLpdxjqywmZomZBBWBWIKJpXJhARYXwdZsjx/MLZ2hYQP6YpFVVC/M
 ycwiGofw55RdBaNVHSVzTP/3puqi4HtH8mLDHkgUxGzZwaJbGRC3aDQDWrsCLTRXBRdF
 M0JyXprR8KrVjMbseGBmp2NAiHgXAK2dUViBf8kpSpfic0rHaZnlJP+d8HcsjtLP/5v1
 7jcXhiW+txE0P8xIm3s6n+kihe0tDKlmjKsGYl+tt5YOigpJ1U8liZ6Lf7zvrsT4fyjW
 MQlwMwfGiPcraZ/iXjNfKbZNQNZzEfPcSB4xNghAk0pwpNVCtpmz4eHlL+gKPN1zMavh
 iE1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAN99F6/rDp+EoR9R13puZBdlhBlDcaOFmTh56eUEgLKGVOGe9tNsGtpZ6GTIIXutZftoFXeUe/WA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPmSKIVs4C+7JGNvkX2aNYlkWbak4L6YvHnxvBGL0vBz4h5Fii
 8HBwFHeOdpvc49uuugeyky9yL7W6iZS1mhIMqbPaT7QtlH29MohpTB9ng5muAw==
X-Gm-Gg: ATEYQzzfDv3pqWVuAclKQxHEnNCR5ATSh8m+AJ021FThfq9AzrZWCmQKfPjP+sT6fAd
 pHke3qlxn1w0k4Uv87PkQ/8Zcg8/GYWCm5QHe3l6gXDgwR1SVTePCD4V14TqT9sY/9r3jINXURx
 5iz+xZmnMThK3jGFLp8TXELzkMua8w0udb2MwhrpviyKpvPxU752Zf1O8c8bqlDoPtXAsFYsCgV
 4rb/aGMS92zlRB2A+6lINJxJmwlgd588e4KrkI6Q/rKRG6QaX+vNtVL6u6Pvk2rcmpRc3UV+L1O
 iNbyVmw4ye5auLT3xveyYu3jUlpcK6ZHzXooPQ1LZ9Wh+p67xjMsPZpqVIZZsgAiyqCFOGJaFYS
 tFo6E1NIoM1D6BYHPMsp/23P594Smbb0IIh3iTNHz2NCxtgYaQ/xLlNLK7as1oWZ3I1SyyzgHMj
 psMVe2EIUc1oGAVu2RhxIirCd5iWu8r4VIZrUKJL1nmNHDXB1BHQj+gj+Rlgqpwjz/U6h0z+hO9
 YF6L7LouEgSJSqMnFMl39fO4M4mFlNW8WHbOCIwGYS/OFfhsYfpZ7hQDtRfxzVXlHnHZC9L
X-Received: by 2002:a05:693c:2c06:b0:2be:833c:14a6 with SMTP id
 5a478bee46e88-2c0e5044091mr1153364eec.15.1773807373685; 
 Tue, 17 Mar 2026 21:16:13 -0700 (PDT)
Received: from 2045L.localdomain (130.sub-75-229-251.myvzw.com.
 [75.229.251.130]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e560fb5fsm2790870eec.31.2026.03.17.21.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 21:16:13 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: hanguidong02@gmail.com
Cc: akaieurus@gmail.com, dakr@kernel.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, gregkh@linuxfoundation.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, me@ziyao.cc,
 pierre-louis.bossart@linux.dev, rafael@kernel.org, rander.wang@intel.com,
 vkoul@kernel.org, yangshiguang@xiaomi.com, yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH 3/4] soundwire: debugfs: initialize firmware_file to empty
 string
Date: Wed, 18 Mar 2026 12:14:28 +0800
Message-ID: <20260318041446.9066-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317191029.43515-1-hanguidong02@gmail.com>
References: <20260317191029.43515-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

On Wed, Mar 18, 2026 at 3:11 AM Gui-Dong Han <hanguidong02@gmail.com> wrote:
>
> Passing NULL to debugfs_create_str() causes a NULL pointer dereference
> upon reading, and creating debugfs nodes with NULL string pointers is no
> longer permitted. Change the initialization of firmware_file to an
> allocated empty string. Existing driver code using this field handles
> empty strings correctly.
>
> Fixes: fe46d2a4301d ("soundwire: debugfs: add interface to read/write commands")
> Reported-by: yangshiguang <yangshiguang@xiaomi.com>
> Closes: https://lore.kernel.org/lkml/17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com/
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>  drivers/soundwire/debugfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index ccc9670ef77c..d4abe8bfca76 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -358,8 +358,9 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
>         debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
>
>         debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
> -       firmware_file = NULL;
> -       debugfs_create_str("firmware_file", 0200, d, &firmware_file);
> +       firmware_file = devm_kstrdup(&slave->dev, "", GFP_KERNEL);
> +       if (firmware_file)
> +               debugfs_create_str("firmware_file", 0200, d, &firmware_file);

I initially patterned this fix after commit 8cc27f5c6dd1 [1] by using
devm_kstrdup(). However, I realized that approach is flawed:
debugfs_write_file_str() calls a raw kfree(), which causes a mismatch.
I have submitted a separate patch [2] to fix that existing commit.

Additionally, firmware_file is a global pointer in this driver. The
original code blindly overwrote it with NULL every time a new slave was
added.

To fix both issues properly, I moved the allocation to the subsystem
init and exit paths so it is only allocated once.

The updated v2 patch is included below for review. I will wait for
further comments on the rest of the series and include this updated
patch if a full v2 series is required.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cc27f5c6dd1
[2] https://lore.kernel.org/linux-pm/20260318024815.7655-1-hanguidong02@gmail.com/

From bbaff3bc33746a965a2387ffe8302d05e700a1c3 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 18 Mar 2026 03:10:29 +0800
Subject: [PATCH v2 3/4] soundwire: debugfs: initialize firmware_file to empty string

Passing NULL to debugfs_create_str() causes a NULL pointer dereference,
and creating debugfs nodes with NULL string pointers is no longer
permitted.

Additionally, firmware_file is a global pointer. Previously, adding every
new slave blindly overwrote it with NULL.

Fix these issues by initializing firmware_file to an allocated empty
string once in the subsystem init path (sdw_debugfs_init), and freeing
it in the exit path. Existing driver code handles empty strings
correctly.

Fixes: fe46d2a4301d ("soundwire: debugfs: add interface to read/write commands")
Reported-by: yangshiguang <yangshiguang@xiaomi.com>
Closes: https://lore.kernel.org/lkml/17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com/
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
v2:
* Replace devm_kstrdup() with kstrdup() to fix allocation/free mismatch
with debugfs.
* Move initialization to subsystem init/exit paths to avoid overwriting
the global pointer on every slave probe.
---
 drivers/soundwire/debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index ccc9670ef77c..2905ec19b838 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -358,8 +358,8 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
 
 	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
-	firmware_file = NULL;
-	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+	if (firmware_file)
+		debugfs_create_str("firmware_file", 0200, d, &firmware_file);
 
 	slave->debugfs = d;
 }
@@ -371,10 +371,15 @@ void sdw_slave_debugfs_exit(struct sdw_slave *slave)
 
 void sdw_debugfs_init(void)
 {
+	if (!firmware_file)
+		firmware_file = kstrdup("", GFP_KERNEL);
+
 	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
 }
 
 void sdw_debugfs_exit(void)
 {
 	debugfs_remove_recursive(sdw_debugfs_root);
+	kfree(firmware_file);
+	firmware_file = NULL;
 }
-- 
2.43.0

