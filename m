Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE95606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=MCZT2TYk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D62B310F143;
	Mon,  9 Nov 2026 09:42:55 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0453A10E864
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=WpuS3tl/9SY725+kelTs43BOQAK8wOu/36MUkoQjfOg=; t=1794217369; x=2109577369; 
 b=MCZT2TYkx8fyB1+znFLOXcjAHBOitCXEHvr8TAgyfpwV/mjAKxlEAuuLMXLCe3Ntzmgn1golAOv
 M3eOYwfwTHJ1lw6L19V52w2mTLhXcT1DckTF2RtaQXB21GuJ6FBb6+0Qi3CiUiSePXF+iDDT+l72R
 Sw3B1o505mBin50jQ0HcbUnlPzYXcEYL6ndeT8aFWyklWNsqL3yEeQcU6kkNxAxdGWb3obIF3js4L
 OPFILtQzdl4bZVqOkU01SOIVnwh3xYB1kPaAIN4+9JuM9p0ltuuKm58z7xcN+yqbezzRONSRlXCJL
 EyjrbNcjAbdiCbUYmNznchficPqsZpWKY5ag==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQLtc-0077wF-Oa; Mon, 09 Nov 2026 10:42:36 +0100
Message-ID: <0173372b-40f4-40d9-b99a-23e29310e469@igalia.com>
Date: Mon, 9 Nov 2026 09:42:35 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] workqueue: Add support for real-time workers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>, Steven Price <steven.price@arm.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-5-tvrtko.ursulin@igalia.com>
 <5582fb8a609eb8a2348811ecb6f539a7@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5582fb8a609eb8a2348811ecb6f539a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Tejun,

On 05/11/2026 18:50, Tejun Heo wrote:
> Applied 1-4 to wq/for-7.5 with the code refilled to avoid unnecessary line
> breaks, HIGHPRI_PRIORITY renamed to HIGHPRI_PRIO and RT_PRIORITY renamed to
> RT_PRIO.

Fantastic - thank you very much for the support and patience!

Regards,

Tvrtko

