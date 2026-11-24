Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12608606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=IPe+L9NY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7206A10F658;
	Tue, 24 Nov 2026 15:15:58 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4BB7310F655;
 Tue, 24 Nov 2026 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version; bh=opgmCa4GJ4PObKNwnikjQ
 2tZDyntqS1dxFo9rFAQ+SA=; b=IPe+L9NYpMOJXM0agMc8aXE1mi5BjuqwqZlBV
 GYFewm1B6D1pwPZBxe6uRMMZOBwav0NDgHLF/o//pqXrtjdJ5DFJE9fxygQvbUwp
 enJnFY0eVCp00FvvMRoO+6IDECYe1o52ILFf6qH47gIJRhJtZZX4PXXzPDPaX3zk
 TRIycI=
Received: from [127.0.1.1] (unknown [114.214.193.58])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgA3w0ccqgVrmbbyAA--.1233S2;
 Tue, 24 Nov 2026 23:15:40 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: mdss-common: describe
 additional block resets
Date: Tue, 24 Nov 2026 23:15:40 +0800
Message-ID: <179553334050.1285678.9600414747998960135@mail.ustc.edu.cn>
In-Reply-To: <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
References: <20261113155635.1677541-2-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: 3pYKCgA3w0ccqgVrmbbyAA--.1233S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1kWryfXFW5ur4xWrWUCFg_yoW3GFb_CF
 1qyFy8Kw4jqr9rJ3Z7Gr4agr1avFWqyr1UCrWrX3yfA34DJa4UGF9rtFsYvryfJan0qrya
 yF1DKrs2yr1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
 1UYxBIdaVFxhVjvjDU0xZFpf9x07j5F4iUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFt24wAisB
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

*** AI-assistance disclosure ***
This reply was drafted with the help of an LLM coding assistant.  The author reviewed
every line and takes full responsibility for the content, measurements and decisions.

Hi,

sashiko's review of 1/3 (2026-11-13, [Low]) says DISP_CC_MDSS_CORE_INT2_BCR (0xa000)
belongs to the domain dispcc describes separately (MDSS_INT2_GDSC at 0xb000 and the
mdss_mdp1 clock family) and is not an interrupt controller reset.  That reading is
correct, so v6 would describe it as a "secondary MDSS core clock domain reset" in the
binding and in the commit messages, with no code or DT change.  Would that v6 be welcome
now, and would you rather have the series rebased onto current master first?

Thanks,
Qianhui Xu

