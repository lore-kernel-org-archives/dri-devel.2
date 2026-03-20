Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2763510987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6229810EB78;
	Fri, 20 Mar 2026 16:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="a/8Cs76R";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737F910EB58;
 Fri, 20 Mar 2026 16:41:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5D4A04E4274C;
 Fri, 20 Mar 2026 16:41:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 33E7E600E0;
 Fri, 20 Mar 2026 16:41:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C15DA10450CB4; Fri, 20 Mar 2026 17:41:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024899; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mIRxnse/bjPPWECtFbLS3qtkgeOBiGcVMkxi10dAPNY=;
 b=a/8Cs76Rcjo7ITzALwQ2rd1dvgxPdw3Yvfpjm/ZXLtw2iM2O5ux78gO7iujFYT1e+Goczt
 s+o7Bv5Qd3Aze7HFyl8S+uTd9iRT8eZ/7/c/uwpEcvUcprXwya8F1whdWZV90CcjYOjnG+
 TcH95X79OBskrIR2oZPITg2haKg0jAG5pAPK3KNqy2i9Vi2sZYQsaeGVgO6k1IDmE8oBdj
 yTL81TGL2qQgEpMhKFYTRmEeo/KBDWK/ZhSHr+p1R5X22AKUmWd2SxR9uhU2atlCNia7C5
 xnsrzaqjtk0KpHL2qb/veCw19lyXIoQPFsHEdq56eYNmg7Izkd7beszs2stacQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 02/65] dyndbg: factor ddebug_match_desc out from
 ddebug_change
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-3-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-3-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491428.6181.7197154425270052236.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=707;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=CBH10i8maWiI1e43S3YE/3lAIi/KXU/tS8OzZuccAy4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjWNzHJAjhVtO1V8zVjbtpDQMEluh81hlg43
 s5KqnDSwN+JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOIO/g/+IihDoiLQ8/fAZefVIZ+YfINI4KQdXiS
 9ZJseJd7dCO75LLWP+m4uQA6KJQZP5KjIt1c+grrrVklXPhMxLlgUHPjdSNyX1+zHGhtVGJ1qLW
 BhKxkQYu2VeQ+/c69Qm+NT+LH+v6GC+3DgkFVjxey+C+S4DqIigRBrQXXzCjqqmkNNgWQcinFo7
 nID6KII/nO9eqWCO/jTr3Cm0uTACz22db7Yf8t3s3vo/AwTt3orVr2LQKVkyCvorBxeP4ib+KD9
 t7VaNCg7HHVyUfZP9icnPwavgHSYNv2jwGNhDPyMIpt1G77XIlb+kef15Ge9+3Xy3CrLjwzvFe5
 esf+9ewWK+Hnm0L5hgYVNPE1i6dGk8Rdb8OY2QOJM5zDo0OuYtk+6LzzCDK76xms034mE+xzCTR
 dwZ9Y/syDv+0yfETMEoEdzx6FBU3BqibUfspekpInFX1IsuJY4PxWJixMWIZk4Al1crcZjIgokR
 jsMT/Y6VnMcv0BBlMXL4MC9Y+BqMfPKb2QTxOPNLYv3J2Auui2qeNlu5nFx5UNxqOdG0uzZURXh
 flqN273cs4BJ0qAbR3RaovdfEK8ruEj4/lDIoPHMayiVAXwWtxPK6n6kYlKMkPauf684xvu6aR5
 pqCmo2z9MsYDBmDSN+WNud0+D7PkvfAga+NezTn0wxewQnsiO/xQ=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:19:27 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 18a71a9108d3..6b1e983cfedc 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -172,6 +172,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
>   * callsites, normally the same as number of changes.  If verbose,
>   * logs the changes.  Takes ddebug_lock.
>   */

Can you add a bit of documentation about this function and move back the
above comment to the ddebug_change function?

With this: Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
