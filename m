Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F0606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GYF4lRi1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75C610EB4C;
	Tue, 17 Nov 2026 18:36:10 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDFF10F88C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:36:04 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1ae58d17cd9so124315c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794940563; x=1795545363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
 b=GYF4lRi1VGHWiIOLfU/Q+fH4iAJsx343mtdH36T/a93eGYXNcnlViBfRVFRrzCGHi8
 fiMPQ8FzWybyriX7k5F6EFqJRyZzO40hJHTRARJ1BsX4OUiIOvOwJFL2aP03MV7DXsUz
 SN+PPanUpqN+Beij9E4DiVx5rEk/LH/9ysdzO1uOkS1jEMQGg0van7Deosvstpe1uFJd
 JjvxIPhjA0RJyhA4uSglZ8RiBfCLZGDQ8te/cOk0LLMln31gZ4TBKQWA9YcmJ/PB7N28
 pUD/uEG6P15uln24aqY2zaqVK2Pk0CE6/0dDrAx07QOB0YqiriMudZ6PJzCoNrMKvt46
 Obxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940563; x=1795545363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rd0/jqMJRNHoYlSsIu6TbBr2fty8j4sVOq9BB4+EiWo=;
 b=Hp8rrIaCNkpGr9tsUkWFQAb1Zk5/hRhJVU4i8v9967zn28n0ksV0h6wDlH8solvfdN
 asGwzOVgDUpASdspHdj5tWwmb57/EN74nqbEHvBM4LwmXIucxmoxh4WeLfVQ8wP3PVVB
 YSPVREz6/DaisaIt6D7bneo0iP+U7kRPvjdOCrWegDLG+/OAFHYlubvKF5UMsZikn2ru
 kBBlO3AKgse7KeK05ia7pp+E6aUXJEKa1fmmzcx8Ws38bNriGnMfATbVakcKfN14XfUg
 u9eJGruIRWu6fAeB2vjgjsLZKcqCJKqRZOuembv4Plqmw4HbJxawBoUs+jWTHd2u0PuR
 Lumw==
X-Forwarded-Encrypted: i=1;
 AL+hErG56vcKAoDsflcwUoZrrdhTI2omlpcSYc1bxeoeBg3Ab5ET4a/wG/4kHLB9DdOq0C6Q/FeGJyekOKQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9WS4yGfwlVPjlSZp2kefwt5RmYuJrPvZQq1+cqGkivMF2mAE4g
 qaWDsnuEi6i8LOAl+jlHurDBUhL72LdzswuPWle7nJAORL+eQyVNOO0=
X-Gm-Gg: AYBFou1jVncMOLWc0aY4pagp7oEBvDL2MkdmU/NbrB70rj5fJi8t6whmmwDOW7Z856P
 5hkt7KwAKIJ2bmjTkyN36fuO+Jaq1O6J2B5aPISObOPyoIyDeAvG+VyeJbp+410jRODNpCHkJAx
 C5WM9QoJ2fC0zlCSgTbe6NlaSFvT/dC6wqn2MmK6Hsl/cZhrZNFGsRstdbe834PAsOTWVs4BofS
 EPxJ0t6MFLHCVRLdz3G7KYUv72q/TC+Biotewkjn1xzaJieC/jykt8LYdD7l1AJ5k+N9V+8ZTSS
 +CRQfKuQ20nCAExmmvVbXrvSkRVWW9J3qmxWTgpXej5MiytoqV+i0pfkzOisqXMKLVnobJiyH+k
 ++W8L6mKuSVB/ZwVIO7zpUUaYUDoC0nYrEXLdF7eIMOh+D/dt6yLZDNgtbDCNcO9w1bDQZQebbs
 Xrb+dTL0STfkpSqUS++mSTNaJKJYVsyxIya77BBEBe4h7nr2grS35wM0QWYg2/VPO+jaLkf24BR
 xn0NOtfSYIf3uRIavtUbqb8PGmZop0XdUvHkZsHA45m+9LK6rizt36z9c5VsTGlK19EmZE8Fe8z
 mXuUUIi1SThrsyEMJwFbG6xPkh+KbrA05ntex6ogz3Kjk564f9bBwv4l2nWVOmA=
X-Received: by 2002:a05:701b:2409:b0:1b3:b833:6565 with SMTP id
 a92af1059eb24-1b543cd7213mr469644c88.20.1794940563273; 
 Tue, 17 Nov 2026 10:36:03 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.59.94.173])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-380d5135221sm10562926eec.24.2026.11.17.10.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:36:02 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, szgit@icloud.com, tglx@kernel.org, x86@kernel.org,
 yossef.osman@proton.me
Subject: Re: [PATCH v2 02/12] PCI: Disable pcie port on specific amd devices
Date: Tue, 17 Nov 2026 13:35:46 -0500
Message-ID: <20261117183546.1214-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116202343.GA205416@bhelgaas>
References: <20261116202343.GA205416@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I don't know what's going on here, but it doesn't sound like typical
> PCIe behavior.  If a device is powered off, accesses to it end with
> some kind of PCIe error that is not normally fatal.
> 
> It's basically the same thing that happens when the OS enumerates
> devices by reading the Vendor and Device IDs.  This has to work even
> if there's no device present, which is essentially the same as a
> device being powered off.
> 
> So I'm not in favor of trying to avoid some accesses to devices based
> on DMI checks.  Even if that works, it doesn't cover other paths like
> sysfs.

I agree, this is not standard behaviour, this only happens when we use
GMUX to turn off the rails (which is the thing that causes power savings).

Accessing PCIe space after GMUX has cut power to the rails will cause a
CPU CATERR.

Also i dont really have ideas, im not really familiar with PCI core.
Can you give ideas, you have please?
