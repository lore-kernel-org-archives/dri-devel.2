Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE7606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kC+GV5J8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7311B10F2ED;
	Tue, 20 Oct 2026 07:36:29 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4444989711
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:12:58 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-3535a54c09bso1832204eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792401177; x=1793005977; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t/h5DpMhUIYeLONHjlycBELUNoQmFT3rwegVO/JrzCw=;
 b=kC+GV5J8u9oCqUL6LHGalVF5IDgJgwGShl6UgaCBuYplAXX1fkkQtzdrx19Xq0C3f2
 QCaBSMleSvLgk4PubSfmyrfHTcdrgXZKZz5jXdn9g75Hk+eZ1u9DiRC5V06nI0Xow8P4
 CihZ+O4eBZ+AB7szqRB2E+lsrJsprksm7jHuz8+eOHSLqgyMGxk0jLkijRUK/DyuKvNc
 Rme68SBz1x0SW35/Umm9Id4duO8LG1qmehrMXASpiTRSidMnyoTxQtaIpzIEPxbcElkZ
 b40UwdiXs1oHDVr6vyuLbpY+7uYfNWjCyzRP2Q5W5p9z5w2quiJXwS7HMIA3Z5pUWd/g
 rGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401177; x=1793005977;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/h5DpMhUIYeLONHjlycBELUNoQmFT3rwegVO/JrzCw=;
 b=iuZuraxB24cuCmo8rFDHemYkakZftXFsKzEtCro61t5PpemwyNO6578gOZmgdceFZf
 w+9V49nWVoc+ytzwUAmwEnUrXVbD5XaNyIj2OD9F9s3Sw13JJxxhlzGFZzLSr8d6hQzl
 lAWF9FkNkL/Qw4ZvmkbcWv+TT+KSwfIvD5DS6zeQXdwC9ivDQ1vGwNjReVI5aoPp8aay
 jzpObwzXZheXKcLpe768cdnQLy2T5/raFQ8l3DPDt+odChyqo1IpvAGp2bq4ZaufqzRX
 RLbunTiqCNU5BxiDenKIfyhvwJguMlFGAFOPssGAJqdoeKYGLXKEF3zSjz7pm/ZWFCBK
 Nt6Q==
X-Gm-Message-State: AFq9FYILW2fwdyr7bDHGiwAFZPIMtBLB+5PHjSBxTcZ459tVPwPlRkmI
 rcZeI3F66w2T/94S5zGLyQKe41NnoDv87mQtcTp6+Umo8aGGHYlfVKQA
X-Gm-Gg: AYBFou0yVZvIchJ2s8BKGpmx2lHYQGw+9h9UG0fa42alf/qrbWJv/53bhz981K5eZE5
 YpH9j0ZZymzhcXKjMilfZFhBo5eMPXF2iMU2nWzUmIoSnH51/KGtCuerGw5qxg51cYJaPTF5e77
 cFsqn5IR+lZ28/UbBCPjCl5n3Gr0xgaV2Le6Jza6j3WaAylep9pqLYW1dcUz6f51S+SiXb2SgAa
 5ukTkiLKgHouPlmqNr/F1Nznwm8yOrfEaFNSOOIbyR+plOaq02mHY6KpXg7GZB996h1Eph0CjVk
 V6vRTZS+MAsFAlAba6nyh6VZNo8N60CEHtBJVAWJno7iL07RJy55JWEx3h9a5fKY+H+6/3JmJ8y
 u7iPHXhUZ8P3FTDVCdw7nFAB31AgFTZfbeO+Zwt/KoeODqqqfmOMi6hcIjETduCZ67arJMW99Kx
 PfpE3LTdPHl5adkX3BZziFeyl60zJM7PU9/bK99RLIL6Ar9a7cDO2s2dhONGLYRmV3GCd1X1kJr
 vBr2oNqsA0=
X-Received: by 2002:a05:7300:d588:b0:35f:4780:518e with SMTP id
 5a478bee46e88-361a16609bdmr11651555eec.16.1792401177429; 
 Mon, 19 Oct 2026 02:12:57 -0700 (PDT)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360819be413sm30693119eec.13.2026.10.19.02.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:12:56 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:12:52 +0800
From: yyaqia@gmail.com
To: Helge Deller <deller@gmx.de>, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fbcon: Include font geometry in the rotated font
 cache
Message-ID: <atXeFarSzZcJmThe@blue>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-2-yyaqia@gmail.com>
 <b93a87be-f55d-45e9-8705-74a5c63600ab@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93a87be-f55d-45e9-8705-74a5c63600ab@gmx.de>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-18 16:05, Helge Deller wrote:
> I've replaced the v1 version of this series with this v3 version
> in fbdev/for-next git tree for further testing.

Sorry, the patch was not good enough, Zimmermann reviewed the code and I
did some modification after that. So we might need to switch to v4
version, sadly. Anyway, appreciate your continuous work for testing.

Thanks,
Yao Yiqi
