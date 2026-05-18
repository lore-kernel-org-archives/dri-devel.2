Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2C8CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B459B10EAAC;
	Tue, 19 May 2026 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RcAa1nsX";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B15710E5D9
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:14:43 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so960319f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779120882; x=1779725682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
 b=RcAa1nsX/Mfhg1jEd1lPK97fQPvVnriYYsrBjfTgr9/TViZ8LirJJB9jjBsN1z5PZF
 Q+Av3dsLhUkA2lwUL+zDQ8a3w6r/FHfs89o+GnV8c+HOKGoZdbKb9P2OGt2ovBAi2otn
 p0EP45xBibGD6S9mhdQrEINRMWGhGmeWVIqsqBPJwwqBKscem919Qa3R2kv16xE5+R0z
 imJo3fpDBeCz648w9SAcs0Sli3L/DugmTImRKAfkUmGoI4mzT8QEEiN4OJDZxUMURwz6
 LMOduiAUCSBXX2zgcjHjvabzVSFDvDpR+VY2JXzDTzCJ6pAEBP0DzGRd2R4r2oStodMr
 ff5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120882; x=1779725682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
 b=nribVIg7so6kJjnniFPcz2X5mGbYJMZt6m+bd7atUNZCX7O2utan66CNHDHDLSvo7c
 W0/S1ptAOm2dm0CJQeJCUzXZTJMTk8CofQSgYL8bzD78DmS8tAnbktuxnsQYU8jZ0E9y
 vuiPVvEO345IOPh9GVi0TFkxVHBKAarjnIzEL3fulgertyGauWPuJWZ+YQdvkbt7Mh4L
 gx/g0i6lgrs2dnyFKILEuRCsBbcrSaWVFd6klyzuwz2eF27svOm5CdP+QzbT4yZeN+zK
 swnwngnJchbhbhefQej5VNtd0/eEAmPHmizymGql9VNkSxRdu4Mg6U062h6CJqVLPWXM
 GsaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++BUtJMlr6nFc3PBnD9KjDMkrFCvIhogglOjKH43t1VG+Ld6JIk/99b6/d8oQHiRyTF5EfcBQsxGM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKzV8H9w9KdX3U2omJwyl7mSFtXUF5LRymiowDsYTh+KEc1vEC
 EJS+hUnhkzKlpinbt1WwYyx/12jpSdfBpkAZNHxWUGeE/b2ZXAPt4K8Z
X-Gm-Gg: Acq92OEb0xw1CKYDLu7YLeh9zjLxHvvPQoPW7CoQMlVNgRl5tio1rkEPRHwHhwymROu
 SeUjwz+RrPDQeghLhGVau+rvvitJ+6Wkg729FUEWkoPRN8MySYJAv4yF2259RxK384K7IcHYusG
 Vl6E5tsrZljDEeDuQH/AQ81/Ew6gpXdvclAx8nSluRwZOk0XYiqJf/ak+dzoJK9GqnHG/Luy554
 hulwOYUHT04Wds0okaoG1aOM09TUrz1r8ujZE0R3vCfezDz63F5xR27twFtEPXCtJJx6SuofBOa
 C9BIDhmE3PjKiU5+mPaidk/zt1zZUIzMLMz9jCpDvySkp6peBshsQ25/QQW/Aur0sNizkLV81Nm
 ky75ZzNZb9a9hp9qYG+pQlMGRNjucm3teibpkkYABZHl1X3lDpvVnZNAdT9Bxk5Zri3rZMfPFM4
 OragZfdPQG5nUFfBZeGaN76oKyOeuKUgApHw==
X-Received: by 2002:a05:6000:1aca:b0:43c:f247:4792 with SMTP id
 ffacd0b85a97d-45e5c5be70cmr24447586f8f.12.1779120881786; 
 Mon, 18 May 2026 09:14:41 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3acf7sm38316771f8f.12.2026.05.18.09.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:14:41 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: chipsfb: add missing MODULE_DESCRIPTION() macro
Date: Mon, 18 May 2026 18:14:36 +0200
Message-ID: <20260518161439.556-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
References: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

Hi Helge,

Can you check my patches and let me know if any changes are needed?

Thanks,
Rahman Mahmutović
