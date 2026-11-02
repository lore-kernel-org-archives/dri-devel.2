Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99105606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=gE2WB910
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B648310E57D;
	Mon,  2 Nov 2026 05:52:17 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1739110E57D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=0lZOsx1LITFD5ecgwcUKK
 yKeWawlR1YqeqpxBeLqpGk=; b=gE2WB910j+ONZS2euuVNnSmtdyU9caSIH+BD3
 BnAznh3AQZYBNZDvhUEinGh7yDgcAeV2JAEb9hxg186kAg+ehrt+1v12+IgfIzDv
 1/b3JFALzlF527LHsRK7yWGjHUrZwhn7etbQ6ptgYgCydyGc4oPPprND0A5yK/SJ
 BgzMuk=
Received: from [127.0.1.1] (unknown [114.214.182.90])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgD3ej8JJehq8uV1AA--.402S2;
 Mon, 02 Nov 2026 13:52:09 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
Date: Mon, 02 Nov 2026 13:52:09 +0800
Message-ID: <179359872977.440050.668410399098679331@mail.ustc.edu.cn>
In-Reply-To: <dkwloahmxcka2ykjdrf6nh6d6cde6zgd7fe5s763h7s6nv3eqe@pm32d33ghgbb>
References: <20261029123238.29877-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261029123238.29877-4-xiaqinghuan@mail.ustc.edu.cn>
 <dkwloahmxcka2ykjdrf6nh6d6cde6zgd7fe5s763h7s6nv3eqe@pm32d33ghgbb>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgD3ej8JJehq8uV1AA--.402S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j
 6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
 W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY02Avz4vE
 14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Au4U
 UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARESB2rnk1cDXgBVsE
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dropped.  v3 is at <20261102055026.438521-4-xiaqinghuan@mail.ustc.edu.cn>: the
node lists only DISP_CC_MDSS_CORE_BCR and DISP_CC_MDSS_CORE_INT2_BCR, and the
binding and the commit messages are trimmed to match.

Those two are what the failing boots leave unreset, so the judgement does not
depend on the RSC.

(AI-assisted draft, edited by me; content and decisions are mine.)

Qianhui Xu

