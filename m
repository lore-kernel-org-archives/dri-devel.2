Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4125606A335
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V7b8rNtq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA1C10F2FE;
	Tue, 24 Nov 2026 08:39:45 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6F610EC51
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:43:21 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so4894502c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795452200; x=1796057000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LkanCEy56313GwKdNz3yPq+fvhbMpSjimDlTmzHOaLI=;
 b=V7b8rNtqDkPxYKY2qr5Gvw1n0zdB1tGmZRLq92PAyKgPC1ljMxQokFExgPBmoQ4Suu
 n6Xoa/zkwsF3t2fQOh02LdTzhrDvI4ipHcpo/q0joYHp8BgHKZeKq9kOdnfNaUOytpKZ
 K7jMnUTLvU8TFhkwjDWOxPjV7bTE1xhD6NuhIWWwt11ewTHYxRV9ZHOHjcalvM02cvnz
 XsKQeKcSjM69wazojZj+m/A198Kzyx6HR6ugDXkXhF140xviLrZ0Dx2Csjb6A36y6Txb
 N5icwWE1lYu9pB/N992uRDHJ6vnXK6L/USfSrpZ5Zf5PHyR/kqK1xbjQXWWOA84qR1rH
 dW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795452200; x=1796057000;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LkanCEy56313GwKdNz3yPq+fvhbMpSjimDlTmzHOaLI=;
 b=zg3LIwWqYtxtdCCC9gTxew70oO1IgvH5jXJSu1KCTZI5QszXnnFvkRwlX6KSizOMNP
 BlzYrTe3Rf2jV8V5KSRUEkUEF+ySj05jXK0kvT32A0FS4CGDaj7hLD2lEPt9hKEfcs80
 Kfpcu/k7aazKWp4j1nmZjgA2NW8gGGrFLFScEzQh+wWy02eoWmhkzPNFNHIKweOjz2vZ
 zsHQMYpoY7FHJzfRVaj6pQsT8LiD3rg4xYlWTaS+XegZTU8SDWx9hrFxVpDazDZY7iD5
 JS7XpyeuBx0iLAvTNqSwt+Vop09Lz/8++POAyT2tGfVnpPL9KYUDHeUCYztjzNrT9ImI
 PKug==
X-Gm-Message-State: APuU4Z+KvO64BnntY85AyWEzVvAKSShFnpcToIDAAfj8FOMK5nYS3uUg
 5M0bmSlKxa3Eg+VurxEkLeUxMwNXbwYD5eaJFT5LJrGu7wOdIXMYudKBh329tUsl
X-Gm-Gg: AZFdTZewFjTNRZqAOxPnIODIT0m4KTFtHwWDy6WxB/p1z3AwYlf500CFCFF+je2APiD
 KxwlgK2j3HmkjW0N/AlVvLVid1bp5+F0lHGFORpfteMR1Di0ygIazAe/GvmkrZuTtyL6HvJLMmn
 aSXSj+G96c8e4NhbOZwkBZ5NggQW0fpFtJ1AibxKhjfje5dUTYHTgXgavf6gB095aMKNCGVe4qa
 8JxDzZ/ump9K/PtV0XpMoCrl9BNzcXdnUA64LNOLyWc881sVhTVKZhUCu0WXjTdQ8+GBS/ps0Yb
 V+1EvkfX/ucrkWFhWl3K5L0Dr9addB0g/vOvupv1iBjZQDWqXea9X9JSFH4MhO0DQgzidmrPuF5
 ncqSLkKhfVHMzmJzfsi+CKRMcCGV2jdEetlpL9nNjgr5agFQKo4+0y0E0qyti1vMKX/3JPcSo41
 GHAHvnMNiyzxl6WuDbadEJpcKS9v2VaU6hj0BWjVWWag1v78ENIEkM6LiE9pqp5aF4Vikf8Zn+b
 WqxkMiMSiv12ehM639eHwDP9wS3MT4d8oPhE+FhnopbptDL+QRl4rk3sJ7PEDfp13JFHsEmBdxd
 0QF9v5eQ3YIjMs9Nnsh4qSKHYQFNh/b/oIK9UBiW7iu8mho=
X-Received: by 2002:a05:7022:62b:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-1b55686d67fmr16770849c88.11.1795452200249; 
 Mon, 23 Nov 2026 08:43:20 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c3052sm29199141c88.1.2026.11.23.08.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:43:19 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>, Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Honglei Huang <honghuan@amd.com>, linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH RESEND] drm/pagemap_util: Drop the kernel-doc for a member
 that does not exist
Date: Mon, 23 Nov 2026 16:43:17 +0000
Message-ID: <179545219715.77822.17551578304982310929@gmail.com>
In-Reply-To: <20261123125127.4114196-1-takano32@gmail.com>
References: <20261123094032.3993177-1-takano32@gmail.com>
 <20261123125127.4114196-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first copy of this patch did not reach the archive for over an hour
after I sent it, so I re-sent it in this thread.  The first copy has
appeared on dri-devel since then; the two are the same diff, and the only
difference is that this copy also goes to linux-kernel@vger.kernel.org.

TAKANO

