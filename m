Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4190606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XbrZB357;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5jqtxL2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACB810F64B;
	Tue, 24 Nov 2026 16:18:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0854410F64B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:18:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL54w2317959
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JUK9FZVx27oVQ4pSxePLEF2P+Uj5XRthoi0CCsG5QJI=; b=XbrZB3571ffCrjYA
 oBODposDgEQh1UbZIYNOuQ6gn6aYuM+kVHuez+ZRb/APdUofHWWz1K0Fjeti6tMz
 v1jK8U+bc2EXaGmmyuegTt/ZwqFZMBA/FXlqJBzfdd3yQxKD+O0kcjWnxSS6GsRW
 6qkcXXOBW/fT173dfVTC0PvZvOB91t52WSXqW6RCZcq8vXH8GzoHmCAnWJ8CLPmr
 /pyN3O4F2zySyAhHxrae71gd6DqJ/53v5K8UBe8wALKGbw6nexPPVbcWoUXQhyYg
 0TbEHzbEKLZDA7zYpju78pESmreAvHJ46yQE0rpAvhi0fO6UiEPR6XeTeKinhXva
 yMI0gQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd3s35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:18:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so5842660eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537110; x=1796141910;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JUK9FZVx27oVQ4pSxePLEF2P+Uj5XRthoi0CCsG5QJI=;
 b=L5jqtxL2n1/3T73aXnFky/nTrN+0OrRRBQyvqGaIP3wKaJinlyP74tLc8HXGnD+tU8
 DEsuiR3FXEXGamjnkUkBV7xsPRdw6XmCs9/GuWQSb10GU/58gu7Mza24Y6wa1mQQNkQf
 u4+4xRAv4lqSS4pYRntAArU+Q/ffuR+fuaeuoONeRajKojqug5j+RnOZheTPaoLb9xvO
 llV+FpjMACg3pOOpZMR/gYR/6IGez4xv+6Yol6+kqMhER1aUYa32NJg58kaDfwPJcGB7
 HsnfPyxqqtstZb3PN8CXF1001EawiydBC27GzKq6h33JRkLh7PQpFRQ7ScsCfua/JNlb
 1/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537110; x=1796141910;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUK9FZVx27oVQ4pSxePLEF2P+Uj5XRthoi0CCsG5QJI=;
 b=Y+ATPjDCiCNl8CGKK+Qx3Gy1la+EL60dmEN/C1GzD12KXNRdVRVZ8t/tAw5+2VVUwo
 42xI9oLSgy9K6/Y9Rl8FEoqVtkkxGZY0x3ki39WljYB5kUnkpyQ/2l6JRMcKFGyrKXeZ
 iiTfC7kIwrX7p8/4EmX4gY6dUG+D57UZ95nThKkRPKveND7Q5tOxL4eN0QcwYLDQiIBQ
 MXh4y9sYeJ5vWQZQ3pUBPpZzyul9D8CqeCbDpB7095rQCNmXm6S9E06Z3e/4tiGls5kI
 4COc6S+s6uUex96du6ElUdhu+wODhDIW3op0wFHA7rbR0zI0y6EPoCtoiJVNWsHnc85F
 Xgbg==
X-Forwarded-Encrypted: i=1;
 AL+hErFUFW6Q6mI/QgXHhEpJxW+9eP2tiHKWxvZn0Qu1jKsT1/XYA/W16S6F3V3crr4F/fgU8H+rHOhRRSA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8bd7Xyeu5g1wUPY/7TK6DoIsU/oiWnUvS43KEoqy5GvnG7F3fA
 Svd4R4zgRHveXduIVpfNOr1V80FdUEM7Lg+N1segjx1UD+HP4Fix+clxJy0JN6oV0QTbPwRjaNr
 UA9Mh0EJRFBl/IMlpmLQ3ecFlxK1U9b04/dgjRvA/2Ts9Kjt8LZ4MRHoQOu/WatmLrhLDcFI=
X-Gm-Gg: AZFdTZevJ6dz9TpdvEbt62ilJVClkmgUI3DuGA3fM6LoAveJHg8zzB2+KuTPc3NDPVz
 h6Rux7iUTr9jUYbFxGymCLvdyWKuNqOWchpqsk2SBIFzLr7wLMRzciIxfOGqpMAEk/98bHG5kuR
 4dxn+fL7bQ7x4+2K50sxzZu3LsgmA4sh7li8VvR14a02pKzQESiTBhWwq43KNKUx5yShuRQRWlV
 pm0mGeVW36Z5P36vrycisnBg3ocnRUaexs4qgUtcgsVlS/vIeNeWRrtlEKNHt7CYBu0RCFflL4M
 RP+gjCDbHrruoG3iWdhjDYyqT99b0WaQHl9R9yroUmz7Mloa6HLKkkjqp5TW5HxdxgpK1n1kkYA
 Mep/CzG7Rgx87uS9ZLWZJ5KqDfY65+GP1j34dK+2cZpPkcGNJOT+9yXozzg/PT4nRs7Ctr4aOJw
 aTYsCHgq98R2zWMinMNP7VcFA=
X-Received: by 2002:a05:7300:6da7:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-3856c9a3029mr21952583eec.2.1795537109406; 
 Tue, 24 Nov 2026 08:18:29 -0800 (PST)
X-Received: by 2002:a05:7300:6da7:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-3856c9a3029mr21952557eec.2.1795537108894; 
 Tue, 24 Nov 2026 08:18:28 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385c6830815sm41066407eec.20.2026.11.24.08.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 08:18:28 -0800 (PST)
Message-ID: <f521ca85-3cbb-4209-9ee4-63e3c8cdf0db@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:18:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/drm_ras: Reference-count nodes across netlink
 handlers
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05b8d6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=zEiQH73GkW7WTHCCbtkA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MyBTYWx0ZWRfX5PPWtIqdjPZA
 gSFK4fyxnhVgGrnxri0TaQvrGX5COt1A2jMEEUnKGG+uLL3HCm3ZBpz2ixb0vd+EAvMIkcXSCzQ
 dD+0BQAhFHG7eE5xjS5WARmVCDWyrp5LM9ZjRyjfbMhY/vj5AtXydBeH5Zyo1aw6v9BKdt1Uy3P
 u/PtDzt/5ILNOo9tIPx3KbthMmEFAVWqXvruNJ5GDZ6283cRfFBFwQGmud1o9nXPYFMl8RNt2JB
 cO+n7tcy/x49FHipi3u0OG79wrdZcNwGGzBTTIMzV4itIhXbU7c9T2XyHQGXN3biDj5Ng7vrirw
 Exe+Yw9xDoUbTnFKsHgy65MjkgQpBGIJgCQmrRVZgmUSzZmVc5BVdVKBK+YCO7fm4hIw4RtwueW
 5eVyDEnUssz5BFFY7UrcqOOSq1g2kufeQEOSiRxhvT8sONSe5jFClo6vexaqMZD7FAIFnrjHDNv
 90w2sdPDTpmL/DlsQ2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MyBTYWx0ZWRfXypNSyLN/TG0m
 Bl1i7JyB18g+FgqLGjGoPeGJOQJVGgd4TlQU4bYd2HlBG1f02ubdqsQmredSb/ciA60nGsQw+bI
 oxdsD4a7vEo8ebHAwWbQ43Y/oGoW+Q0=
X-Proofpoint-ORIG-GUID: iCK4kuPbfSWqo3QmmrS7ZLCy9FGbuvOf
X-Proofpoint-GUID: iCK4kuPbfSWqo3QmmrS7ZLCy9FGbuvOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240063
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 4:34 PM, Zack McKevitt wrote:
> The drm_ras generic netlink family sets .parallel_ops = true, so its
> handlers can run concurrently with each other and with
> drm_ras_node_unregister(). Every handler looks a node up with a bare
> xa_load() and then dereferences the returned pointer across GFP_KERNEL
> allocations and sleeping driver callbacks, while drm_ras_node_unregister()
> only calls xa_erase() and the driver frees the node immediately afterwards.
> xa_load() only holds the RCU read lock for the duration of the walk, so the
> node can be unregistered and freed while a handler is still using it.
> 
> Give each node a reference count. A node holds one reference for being
> registered; drm_ras_node_get()/drm_ras_node_get_next() take an additional
> reference under the xarray lock, which serialises them against the
> xa_erase() in drm_ras_node_unregister() so the bump can never race with the
> free. Handlers drop their reference with drm_ras_node_put() once they are
> done touching the node. drm_ras_node_unregister() removes the node from
> the xarray, drops the registration reference and waits for any in-flight
> handler to drop theirs before returning, so the driver can still free the
> node as soon as unregister() returns.
> 
> drm_ras_nl_error_event() is left unchanged: it is called by the driver with
> its own node, whose lifetime the caller already guarantees.
> 
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Looks like you break reverse christmas tree ordering in some places 
where you modify function local variables, but I'm not sure if that is 
the expected style or it just happens to look that way.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
