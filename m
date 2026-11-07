Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B8606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4DC10E61E;
	Sat,  7 Nov 2026 18:49:02 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8414A10E61E;
 Sat,  7 Nov 2026 18:49:00 +0000 (UTC)
Received: from [172.100.0.8] (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAC3T7WWcu9qyHeKAA--.6613S2;
 Sun, 08 Nov 2026 02:48:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix vm reference leak in mock_gem_device()
Date: Sat, 07 Nov 2026 17:09:52 +0000
Message-ID: <1794071392.2684479.vulab@iscas.ac.cn>
In-Reply-To: <178962823827.28653.5098493516220452854@jlahtine-mobl>
References: <20260916171935.2087305-1-vulab@iscas.ac.cn>
 <178962823827.28653.5098493516220452854@jlahtine-mobl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC3T7WWcu9qyHeKAA--.6613S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWUXr48uFWftryfury5XFb_yoW5ur1UpF
 s3K3W3Ar1kGF1fCws2vF40y34ruFZ5A3yUXFs8W3yUZ3Z8uFyIgFWSyF4jvasru393Wr12
 vr4j9rykZF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
 0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
 ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
 rwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
 0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
 tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
 wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
 9x07b0DGrUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIEA2rvPctHVAAAs8
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Joonas,

First of all, I sincerely apologize for my very late reply, and thank you
for taking the time to raise these concerns.

I have read your message carefully. Your criticism is justified, not only
regarding this particular patch, but also regarding the way I have been
submitting patches to the kernel community.

For this patch, I failed to properly assess the severity and scope of the
issue before submitting it. This is a selftest-only cleanup, and it should
never have been marked for stable backporting. I also failed to pay
sufficient attention to the subsystem's coding conventions and teardown
ordering. These are things I should have checked myself before asking
maintainers to review the change.

I have revisited the relevant code and revised the patch to address these
issues. The v2 removes the Fixes and stable tags, corrects the subject
prefix, and adjusts the cleanup ordering. I understand that correcting
these details now does not excuse the lack of care in the original
submission.

I also want to be transparent about the use of AI tools. The initial
finding came from static analysis, and I used DeepSeek and GPT 6.1 Sol to
help examine the finding and prepare the patch. However, I was the one
who decided to submit it, and I am fully responsible for its correctness,
testing, and presentation. Using these tools does not reduce that
responsibility, and I should not have submitted a patch without
sufficient independent verification.

More importantly, I owe you and the other maintainers an apology for my
broader submission practices. I submitted far too many patches in a short
period of time without giving each one the attention it deserved. I also
failed to respond to review comments and requests for changes, including
requests to acknowledge AI assistance. I understand how frustrating this
must have been, especially when maintainers are spending their own
limited time reviewing contributions.

You were right to question whether I was taking the review process
seriously. Looking back at how I handled those submissions, I can
understand why they gave that impression. I regret that my actions wasted
maintainers' time and undermined their trust in my contributions.

I am changing how I approach kernel contributions. I will stop submitting
patches in bulk, review outstanding feedback individually, and prioritize
resolving existing discussions over sending new patches. Going forward, I
will submit changes only after I have examined the relevant code paths,
checked the subsystem conventions, and performed appropriate validation. I
will also make sure that any AI assistance is properly acknowledged.

I understand that trust cannot be restored simply by writing an apology.
It will take consistent care and follow-through in future contributions,
and I intend to demonstrate that through my actions.

I have prepared a revised version of this patch, but I also understand if
you do not consider this particular cleanup worth pursuing. I will
respect that decision and will not continue pushing it if you would
prefer to leave it aside.

Thank you again for your feedback, and I am genuinely sorry for the
unnecessary review burden and for not responding sooner.

Regards,
Wentao

