Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F530CD5BB8
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 02:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B5B10E075;
	Sun, 24 May 2026 02:07:53 +0000 (UTC)
X-Greylist: delayed 402 seconds by postgrey-1.36 at gabe;
 Sun, 24 May 2026 02:07:51 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2704910E075
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 02:07:50 +0000 (UTC)
X-QQ-mid: esmtpgz15t1779587905t55917f99
X-QQ-Originating-IP: +CMkYgQkelm3p4bzQbNBKmYcwd2gel7t9keJU6p+mwY=
Received: from [127.0.0.1] ( [116.234.26.110]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 24 May 2026 09:58:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1059293555878524542
Message-ID: <15015D7EB84640D6+cc21a9f7-ae1b-4a22-bb38-34d6fafe1bcb@radxa.com>
Date: Sun, 24 May 2026 09:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64: qcom: Enable additional hardware on Radxa
 Dragon Q6A
To: Graham O'Connor <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, neil.armstrong@linaro.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522101323.31911-1-graham.oconnor@gmail.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <20260522101323.31911-1-graham.oconnor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nhi/8BSYHilBLwcaBOl2A72XJ//F0YkO027Go56Z2g3pWCvHEtyb5505
 dNOlg6/1CfpljW/3HZUrpfJDO8cmeeLIuwA3DRJtDC0X1pvYzkCF8+5OJQLs3MYtwZJBJ4l
 rTF2iCKBnEGO/TzCrxHXTa/CZQTOOVlXbVhDBx/VllDBZlVkAKGqfmfucsJ+mZP+9VuR1Xa
 clFbvE76y0u5zA7TJiIQvP1AIxKJgBfBMNfDOzydrD+geuFIVmVJ/39AV55aUi0EaDbvDq+
 LgxOUcj7ppvLtsi1j1yLAd7sCLRT3fK6Jx9NN/wPvkfTbwhZuDWxbJKWiSAQwvlSBOZP0kk
 7qjYPcN/w82vIrHagInxpiHv+4HfZKG/ZKGXDq9tq+vqKbcHj5JIC9Cex1bOCADtFeq3ZN2
 Pu7brkEL5kIxBdANIf2eePTv3oxv1aoSpB9n68zM7qS5me/d92+Prh318Qgzl3Gf1VSJDOd
 gCPeuYi+YWJUbibXtcymhX8YtaCI9WXFuoCeph+JH4lAZeaB7MQg1b/eMfkYL28nIWgVZFW
 1rkili+2bfPFwGUzsFhF08Ve4ZZNJzL01VnrWNy9cqSdB3N+p9Xwb8womuII/yrvQYK5A0T
 ESdTIXLyKYI7i1BrQtqydYtbAIVWmwJZbwZDaCRb206reEtnYKvn6psCZr1fLxbldra9L19
 KLukrQ1a3teioc3BGqvdxnlBW9tu/2+4unXYbdy1awJBZqNi5MZ5fwWXsRqh6FTxBSLNNBH
 DNUzuN+VAU2IuLVpqoOJd48pWZ4Pj0XsIfUa3gRfXW3x1pqHer0E9PEU9MEY4Z/EpuAZ4TU
 QnEIOJfQ/N77u+680qX9fsScEgig1Rev+kBCV8mYy88lsCj1bkQAtcZ/nrV9mngc6T0mwg7
 +lpLRkd1+6xFGFrbTEILAslLFcGtJpvGn5sJb6nmzImZGWk2Nris1epy0Uqv3w8Rw+8VVlM
 Vzu2/vEdIaYStlvF9wWyTHL2y9JJSS72zHlq0BThAzzmfKnTONtSL72SjDK2Vhm3ySseAIE
 FQ4ITHEAfIu/cnnyRaOKj+eaHfphPJZFHIal85FCjyeSobdDMrk0wUGzXYZk4UiDTxP5XC4
 Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
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

On 5/22/2026 6:13 PM, Graham O'Connor wrote:
> Thank you to Konrad, Neil, and others for the very prompt and helpful reviews.
> 
> Based on the feedback received, I think it best to withdraw this series to
> address the issues raised, most notobly:
> 
> 1. The DP_TRAIN_LEVEL_MAX change (patch 3) is too broad - it affects all
>     devices using the Qualcomm MSM DP driver rather than being specific to
>     the RA620 bridge. A proper fix should be implemented at the bridge
>     level. This is going to take more investigation.
> 
> 2. The display DT nodes (patch 5) should use the radxa,ra620 compatible
>     string per the existing Radxa upstream series from Xilin Wu, and the
>     lane ordering needs correcting.
> 
> 3. The rpmh-rsc early return (patch 1) needs further review regarding
>     the implications of returning before full driver initialization.
> 
> 4. DTS patch label dependency issue (sorry)
> 
> I'll integrate with the Radxa upstream effort, re-evaluate the other areas
> and resubmit corrected patches addressing these concerns at a later date.
> 
> Thanks for the feedback.
> 
> Cheers
> 
> Graham

Hi Graham,

Thanks for working on the additional hardware bring-up for Q6A upstream 
support. I'm really glad to see someone pushing this forward.

I actually posted a patch series [1] last month, and it is generally in 
good shape. Unfortunately, I got busy with other work and haven't had a 
chance to send v2 yet.

If it helps, please feel free to take over that series and fold your 
additional patches into it. I think that would be a good way to move 
things forward.

Also, I believe patches 10-12 in my series are no longer needed and can 
be dropped.

Thank you again for the work you have done.

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=1078242&state=%2A&archive=both

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
