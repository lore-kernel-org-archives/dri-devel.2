Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7016606A88A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C3ghXM04
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E26710F6EA;
	Tue, 17 Nov 2026 13:05:38 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3569410F6EA
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:05:32 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso377288866b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1794920730;
 x=1795525530; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/q1oWTkjbDNHWQAuk2EDeZ6imnt0CDYY6KeOw9zQ30c=;
 b=C3ghXM045ViecRcRPHDuFH0jNWYVJHyuVuHKw+BQNtetUrd0e7vdEM0ZR7AMmY8CGV
 yFJ4mGTin4sPCQ5IRh4uacfRFLrPh4tw194GZUHDfDK7W1BgMxb4GCA1Y8nu+Ljl5IQh
 ZpsyUfUjdOrWPc1jvzSxZYz+XIvTEWHGZnUaUP62fFidRnGzd0bnRVQSfqzNBH1IETMF
 hkNbxy5Od+JaUUpVDCLRBnkWnUj/6PIxA1bROzM2OXwSp23mquMcftYfRSSejg0oFuEd
 ZSZ34EZEcGAR6aRbjtOnBbvhJQqXNd+Xsit9r98r3ZqvwZcY0xdmp3A/UtQbNdzAkUSi
 z67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794920730; x=1795525530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/q1oWTkjbDNHWQAuk2EDeZ6imnt0CDYY6KeOw9zQ30c=;
 b=J7DOylnP129QwnaHF1wVwox4khsEZs8ZxPhYlwViBiGq9KRB1o/97OLumdyR9Rso4n
 In/1pdUrh9hE4TJEbV4HsWJuooQcjfDRvhw8KHgkbxpHNIWSf1jUTt5Pt+Q8ym+B48yC
 5gWoMm+pUMSpmz5YwQMXUo8dolw3S9O7QjhvWimh1myzbiNP0sPMeTAI2Hrbqs4wCSxZ
 eW+htHZpPT5uffiwwPOXkswbpIYAa8wnW5XB3Evu7Fqk/hwNbmP/JDcJ9hS6n+AT/T4d
 rz3+oXSYaTE1TNkn3c9FvqUSf0I6Mnv0VDUFXzQNLqcpsBN7t0iNzr0O6KAFg0E9L51K
 s92A==
X-Forwarded-Encrypted: i=1;
 AL+hErH4ZdAn4rgsWm9i3nJnFDOStId8E6lQOAKIPLIW3D1o9Kz5jboGh0VCbsSK1lfPDnFhWEG9/PIjB2c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+izDI+NnJB8gkIL1AIKYFbp8AoyauG3YQgy30xhTmylNkwsLfi
 ZOQA5hi22m7Y4/pYJoysjkjCkwVzIHcb5asKu3UavSLo7/k4fY02O7YPp2FlGF9TT8cikxSqJCf
 qnTLffcuRmg==
X-Gm-Gg: AYBFou1bkxnAOidmMmRb3LRHha5/0xBxuxpBs0h4LnQ9MJnVUOeDXOJ7muC0ZtdBfiM
 fVvgqDBTwAt+AQqLRgRW5w45lyoRVZZ7VJJ6hzc3m+/Pq+V2VznSYhh1avhnzJaXFVntc6a4Ore
 FeLYTcaadyjesJslmjVCY3cInG1x7glYm8sbnIpzEurV0eBzpyQsuWYeZIkK4ipzdHlle17ysAE
 pDhGt/IVA1xDnhkAUdeAVZ+6+CQOklEPmOnwS86uIpg9NRp+LOlnjgzae2bu8TAYK7ywOkxXLlU
 dShc2dAUfAXmsv+1LpPqTgfYHvW+IlwDNOhvIvZAkE5mbqO1BZMdEVfJbORfzzpdUW7qiyr14aG
 VOa0f53Qfv2PX9AgnboJMK3wkGCN2QIWplmIeg6UKqdfLOuDcH+jmcjFnyl3/6gNrkLttsn4S7i
 +ZRivVp3U8ygjIV7IjAshbRSME+yZdBxB0NhmVT3w7kUej4cgMErYx+3djDha/SPEMlMNcq0BOJ
 /WvTj1B+KOMp49K5wNvxuts9NxQmUTa8JzEG2rt7Slz+aExr2kIdgyguPYes/Fluy8xphL4tBKV
 Wn3GHYY/Yl+6uIK5+0dsu6uywvroRp+dKTci8qtsEBgp8dCl9MxOp9M0O6C6hMQ5Z3QrI1gszn3
 3MTBIfAWtrnvwC3vBTk1dpktn4pXnrCyX8PHTOVv82HiDXLK5hQ==
X-Received: by 2002:a17:907:8e08:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c50961d1e39mr1302474166b.7.1794920730419; 
 Tue, 17 Nov 2026 05:05:30 -0800 (PST)
Received: from alcachofa.home (cst-prg-52-235.cust.vodafone.cz.
 [46.135.52.235]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d69c21a17sm22827961f8f.50.2026.11.17.05.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:05:29 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH] accel/rocket: put IOMMU domain on BO creation failure
Date: Tue, 17 Nov 2026 14:04:56 +0100
Message-ID: <179490829259.50223.3008700255330714647.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708114354.753817-1-lgs201920130244@gmail.com>
References: <20260708114354.753817-1-lgs201920130244@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 08 Jul 2026 19:43:54 +0800, Guangshuo Li wrote:
> rocket_ioctl_create_bo() takes an IOMMU domain reference for each newly
> created BO.
> 
> The normal GEM object release path drops that reference from
> rocket_gem_bo_free(). However, the BO creation error paths free the
> object with drm_gem_shmem_object_free(), which bypasses the driver's GEM
> .free callback. Those paths therefore release the shmem object without
> dropping the IOMMU domain reference.
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: put IOMMU domain on BO creation failure
      commit: 90035d3f26e011e16fcf9c5071571f0d956b5219

Best regards,
-- 
Tomeu Vizoso <tomeu@tomeuvizoso.net>
