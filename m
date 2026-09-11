Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E03C88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AD510EA0E;
	Sun, 13 Sep 2026 20:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mp9h1xPa";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5589910F6AD
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:07:16 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so1334658a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789150036; x=1789754836; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U9HgCtbGvHMuINogNLSOBUZfhy3TW6uXI1GXKaBOlKM=;
 b=mp9h1xPawegxS7xF8TG3M+Fptcle8dxOWFmMtzTcyOY7VGBUSrd8ovryVQ3P2+xIcJ
 kTLUtneylqO7rHNMRYc2bqPtFACGYsipDQLrff2/UoyF1GCaS1bCnaGiAMr8jL1gYp9X
 IjQNd5+OdWW6WgawxhHGqVXom8fgSoFSAL5qcvVZ8hXs49nzU8TrLMOqoI6SlBYAotim
 VBJmTGwM+/xVU90+afxOIHqdSvH2R/bZ8AMRkjXbn3ZT1yPjsBGfu5qDyG5B+94zHssU
 672AyQ2+a16XWE6IpyMaU5dpJJ27oxOmrPLYyFiYRSq/tSjoMLleHk+Ahw1qmnknVtl0
 Swww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789150036; x=1789754836;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U9HgCtbGvHMuINogNLSOBUZfhy3TW6uXI1GXKaBOlKM=;
 b=kTYxo/8jDm8SLFaQ/UI+ui0jILzMbB3yOKPbg6NOyG5SkWEZhctLQNbGnGEwppYD6V
 uyEg5wuvQAQu5RH6qeXr+pJ+Gs4JZ0c+463HPLX7QIUWV2qwiptkYQTQtGdACfKSDbxf
 Dy2kmfzH0abDDKWq2NpFoydZ7+iLfUJ+IJeDm0cMXUGrfrlwEPg5S51FbmBFnnJh226p
 CyZd/RblCLZeWOUIUJs3ig2ctr56oTB375T2NHb7cdepFN37VIKvO3tMY+GvaaDUTk/D
 KnMWASSxv1Uc74B1NJVo/5HHJgGjpOa0gArKG+m9OpD5HLudV6p9b4IfW8kWw5k6kytK
 imTA==
X-Gm-Message-State: AFuF++n1KjQrX8hm94Bk3JlLaf23k3GjYcWUBpq1VyxEGNshZyyNgjoE
 oa585CPeKBNflSsa3D5iQFe6bJ4xfuYUl0s1+UohnbxYOrzgVTXfLi03f9lAbW+F
X-Gm-Gg: AYBFou1vABTt7lgwtnZ9ByDlwpxopNk0kJKVQSy5T7SvQzU1cst46vNAdcWboJ1QwCf
 Drhy3k62a9xC4nFKtPfhvu/lJB5ZTmIeWr82wMsTYapxBAyEP319F7hH8mI8mJZuLvbTu8jVbgU
 fhWAzidAiZlXAClICFJ6AnMFpxJX+7toQ6okbJ0jDdLbmF9wanSKdoFNjWADGNv5ad2jxBfVNmu
 N0/ynjgzonNB+v21hoi9Piz4hOv3Dl9waqbGc+T8+s1+nMnksfDWT4exyVJU5bkh7yNhVfb6xKa
 X8ldDp488SHCLhItP88NsrZTT87Z8VskN63gj7+wTSANdMRzgazcKzCL5ABA0SwNPESY4V7RNSr
 Fp2zHJqHSB1jPjIYKgm4pwZVqXuKWjHtTdsLA7TmMbvN9rubduCmIv4Gu0sGDop9YQQiNcSDC1d
 I9isBuQNg76X7V02w9lbuRg54fjR8STjrjP8MOEEyrtbueILfJwZco+lrGkki/S7NHP4rM+ZLbT
 Kqi
X-Received: by 2002:a17:90b:3842:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-39d9bbdc29emr8641263a91.2.1789150035381; 
 Fri, 11 Sep 2026 11:07:15 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e52a60sm7850453eec.6.2026.09.11.11.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 11:07:14 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/pl111: drop alpha formats the hardware cannot scan
 out
Date: Fri, 11 Sep 2026 18:07:08 -0000
Message-ID: <178915002849.197282.4566750970009635614@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Thanks for applying, and for cross-checking the format behavior against
the TRM!

Happy to help with testing on the QEMU vexpress setup anytime.
